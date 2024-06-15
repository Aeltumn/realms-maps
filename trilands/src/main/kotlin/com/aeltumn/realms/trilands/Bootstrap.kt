package com.aeltumn.realms.trilands

import com.aeltumn.realms.common.BootstrapHelper
import java.nio.file.Paths

/**
 * Bootstraps the map creation.
 */
public fun main(args: Array<String>) {
    val outputFolder = if (args.isEmpty()) {
        Paths.get("out/trilands/")
    } else {
        Paths.get("${args[0]}/trilands")
    }
    val resourcePackSource = Paths.get("resource-packs/trilands/").toFile()
    val worldSource = Paths.get("maps/trilands/")

    BootstrapHelper(
        outputFolder,
        resourcePackSource,
        worldSource,
        "trilands",
    ).execute()
}