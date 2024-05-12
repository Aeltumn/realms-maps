package com.aeltumn.realms.crossfire

/** The identifier of a timer. */
public data class TimerIdentifier(
    public val map: String,
    public val type: String,
) {

    /** The namespace of this identifier. */
    public val namespace: String = References.NAMESPACE

    /** The path of this timer. */
    public val path: String = "timer-$map-$type"

    /** The full id of this identifier. */
    public val id: String = "$namespace:$path"
}
