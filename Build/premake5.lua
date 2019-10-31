require("premake", ">=5.0.0-alpha10")

include "module.lua"
include "../../TiltedCore/Build/module.lua"
include "../../TiltedReverse/Build/module.lua"

workspace ("Tilted Hooks")

    ------------------------------------------------------------------
    -- setup common settings
    ------------------------------------------------------------------
    configurations { "Debug", "Release" }
    defines { "_CRT_SECURE_NO_WARNINGS" }

    location ("projects")
    startproject ("Tests")

    staticruntime "Off"
    floatingpoint "Fast"
    vectorextensions "SSE2"
    warnings "Extra"

    cppdialect "C++17"

    platforms { "x32", "x64" }

    includedirs
    {
        "../ThirdParty/",
        "../Code/"
    }

    filter { "action:vs*"}
        buildoptions { "/wd4512", "/wd4996", "/wd4018", "/Zm500" }

    filter { "action:gmake2", "language:C++" }
        buildoptions { "-g -fpermissive" }
        linkoptions ("-lm -lpthread -pthread -Wl,--no-as-needed -lrt -g -fPIC")

    filter { "configurations:Release" }
        defines { "NDEBUG"}
        optimize ("On")
        targetsuffix ("_r")

    filter { "configurations:Debug" }
        defines { "DEBUG" }
        optimize ("Off")
        symbols ( "On" )

    filter { "architecture:*86" }
        libdirs { "lib/x32" }
        targetdir ("lib/x32")

    filter { "architecture:*64" }
        libdirs { "lib/x64" }
        targetdir ("lib/x64")

    filter {}

    group ("Libraries")
        premake.extensions.core.generate()
        premake.extensions.reverse.generate()
        premake.extensions.hooks.generate()

