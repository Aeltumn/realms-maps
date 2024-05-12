import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.9.23" apply false
}

allprojects {
    group = "com.aeltumn.realms"
    version = "1.0-SNAPSHOT"
}

subprojects {
    apply(plugin = "org.jetbrains.kotlin.jvm")

    repositories {
        mavenCentral()
    }

    val implementation by configurations
    dependencies {
        implementation("io.github.ayfri.kore:kore:1.8.0-24w14a")
    }

    tasks {
        withType<KotlinCompile> {
            kotlinOptions {
                jvmTarget = 21.toString()
                freeCompilerArgs += listOf("-Xexplicit-api=strict", "-Xcontext-receivers")
            }
        }
    }
}