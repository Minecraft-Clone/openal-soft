project "openal"
  kind "StaticLib"
  language "C++"
  cppdialect "C++14"
  staticruntime "on"
  systemversion "latest"

  targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
  objdir ("%{wks.location}/build/" .. outputdir .. "%{prj.name}")

  IncludeDir["openal"] = "%{wks.location}/libs/openal/include"

  includedirs {
    "src",
    "src/alc",
    "src/common",
    "include",
    "include/AL"
  }

  files {
    "premake5.lua",
    "src/**.h",
    "src/**.cpp"
  }

  excludes {
    "src/alc/mixer/mixer_neon.cpp"
  }

  defines {
    "AL_LIBTYPE_STATIC"
  }
  
  filter "system:windows"
    defines {
      "WIN32",
      "_WINDOWS",
      "AL_BUILD_LIBRARY",
      "AL_ALEXT_PROTOTYPES",
      "_WIN32",
      "_WIN32_WINNT=0x0502",
      "_CRT_SECURE_NO_WARNINGS",
      "NOMINMAX",
      "CMAKE_INTDIR=\"Debug\"",
      "OpenAL_EXPORTS"
    }

    links {
      "winmm"
    }

  filter "system:linux"
    pic "On"
  
  filter "system:macosx"
    pic "On"

  filter "configurations:Debug"
    runtime "Debug"
    symbols "On"

  filter "configurations:Release"
    runtime "Release"
    optimize "On"
