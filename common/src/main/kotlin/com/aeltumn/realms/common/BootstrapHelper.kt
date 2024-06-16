package com.aeltumn.realms.common

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.dataPack
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream
import java.nio.file.Path
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream
import kotlin.io.path.ExperimentalPathApi
import kotlin.io.path.copyToRecursively
import kotlin.io.path.createDirectories
import kotlin.io.path.deleteRecursively

/** Assists in bootstrapping a pack. */
public data class BootstrapHelper(
    public val outputFolder: Path,
    public val resourcePackSource: File,
    public val worldSource: Path,
    public val datapackName: String,
) {

    public companion object {
        /** Whether active development is happening, during which exporting to a folder is easier to debug. */
        public const val DEVELOPMENT_MODE: Boolean = false
    }

    @OptIn(ExperimentalPathApi::class)
    public fun execute(
        builder: (DataPack.() -> Unit)? = null,
    ) {
        // Clear out the target folder first
        outputFolder.deleteRecursively()

        // Copy across the resource files (after zipping)
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
        worldSource.copyToRecursively(outputFolder, followLinks = false, overwrite = true)

        // Create the datapack (if a builder is given)
        if (builder == null) return
        val datapack = dataPack(datapackName) {
            path = outputFolder.resolve("datapacks/").createDirectories()
            builder()
        }

        // Wait for duplicate entry on random_chance.json to be fixed
        //if (DEVELOPMENT_MODE) {
            datapack.generate()
        //} else {
        //    datapack.generateZip()
        //}
    }
}