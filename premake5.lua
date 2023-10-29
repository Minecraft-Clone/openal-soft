-- openal

project "openal"
  kind("Makefile")
  language("C++")
  cdialect("C11")
  cppdialect("C++17")
  staticruntime("On")
  systemversion("latest")

  targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
  objdir ("%{wks.location}/build/" .. outputdir .. "%{prj.name}")

  IncludeDir["openal"] = "%{wks.location}/libs/openal/include"

  files {
    "premake5.lua",
    "**.hpp",
    "**.cpp",
  }

  buildcommands {
    "cmake -DLIBTYPE='STATIC' -DCMAKE_BUILD_TYPE='%{cfg.buildcfg}' -S . -B ./build",
    "cmake --build ./build",
    "{COPYFILE} ./build/%{cfg.buildcfg}/*  %{cfg.buildtarget.directory}/"
  }
    
  rebuildcommands {
    "{RMDIR} ./build",
    "cmake -DLIBTYPE='STATIC' -DCMAKE_BUILD_TYPE='%{cfg.buildcfg}' -S . -B ./build",
    "cmake --build ./build",
    "{COPYFILE} ./build/%{cfg.buildcfg}/*  %{cfg.buildtarget.directory}/"
  }

  cleancommands {
    "{RMDIR} ./build"
  }