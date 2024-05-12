plugins {
    application
}

dependencies {
    api(project(":common"))
}

application {
    // Define the main class for the application.
    mainClass = "com.aeltumn.realms.crossfire.BootstrapKt"
}