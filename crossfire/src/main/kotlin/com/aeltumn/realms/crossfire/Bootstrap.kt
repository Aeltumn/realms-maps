package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.commands.say
import io.github.ayfri.kore.dataPack
import io.github.ayfri.kore.functions.function
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream
import java.nio.file.Paths
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream
import kotlin.io.path.ExperimentalPathApi
import kotlin.io.path.copyToRecursively
import kotlin.io.path.createDirectories
import kotlin.io.path.deleteRecursively

/**
 * Bootstraps the datapack creation.
 */
@OptIn(ExperimentalPathApi::class)
public fun main() {
    // Clear out the target folder first
    val outputFolder = Paths.get("out/crossfire/")
    outputFolder.deleteRecursively()

    // Copy across the resource files (after zipping)
    val resourcePackSource = Paths.get("resource-packs/crossfire/").toFile()
    val outputZipFile = File.createTempFile("resources", ".zip")
    ZipOutputStream(BufferedOutputStream(FileOutputStream(outputZipFile))).use { zos ->
        resourcePackSource.walkTopDown().forEach { file ->
            val zipFileName = file.absolutePath.removePrefix(resourcePackSource.absolutePath).replace(File.separatorChar, '/').removePrefix("/")
            if (zipFileName.isEmpty()) return@forEach

            val entry = ZipEntry("$zipFileName${(if (file.isDirectory) "/" else "")}")
            zos.putNextEntry(entry)
            if (file.isFile) {
                file.inputStream().use { fis -> fis.copyTo(zos) }
            }
        }
    }
    outputZipFile.copyTo(outputFolder.resolve("resources.zip").toFile())
    outputZipFile.delete()

    // Copy across the world files
    val worldSource = Paths.get("maps/crossfire/")
    worldSource.copyToRecursively(outputFolder, followLinks = false, overwrite = true)

    // Create the datapack
    val myDatapack = dataPack("crossfire") {
        path = outputFolder.resolve("datapacks/").createDirectories()

        function("my_function") {
            say("Hello Minecraft world !")
        }
    }

    myDatapack.generateZip()
}