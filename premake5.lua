-- PREMAKE FOR GLFW

project "glfw"
  kind "StaticLib"
  language "C"

  targetdir ("bin/" .. output_dir .. "/%{prj.name}")
  objdir ("bin-int/" .. output_dir .. "/%{prj.name}")

  files
  {
    "include/glfw/glfw3.h",
    "include/glfw/glfw3native.h",
    "src/glfw_config.h",
    "src/context.c",
    "src/init.c",
    "src/input.c",
    "src/monitor.c",
    "src/vulkan.c",
    "src/window.c"
  }

  filter "system:linux"
    systemversion "latest"
    staticruntime "on"
    pic "on"

    files
    {
      "src/x11_init.c",
      "src/x11_monitor.c",
      "src/x11_window.c",
      "src/xkb_unicode.c",
      "src/posix_time.c",
      "src/posix_thread.c",
      "src/glx_context.c",
      "src/egl_context.c",
      "src/osmesa_context.c",
      "src/linux_joystick.c"
    }

    defines
    {
      "_GLFW_X11"
    }       

  filter "system:windows"
    systemversion "latest"
    staticruntime "on"

    files
    {
      "src/win32_init.c",
      "src/win32_joystick.c",
      "src/win32_monitor.c",
      "src/win32_time.c",
      "src/win32_thread.c",
      "src/win32_window.c",
      "src/wgl_context.c",
      "src/egl_context.c",
      "src/osmesa_context.c"
    }

    defines 
    { 
      "_GLFW_WIN32",
      "_CRT_SECURE_NO_WARNINGS"
    }

  filter "system:macosx"
    systemversion "latest"
    staticruntime "on"

    files
    {
      "src/cocoa_init.m",
      "src/cocoa_time.c",
      "src/cocoa_window.m",
      "src/cocoa_monitor.m",
      "src/cocoa_joystick.m",
      "src/cocoa_joystick.h",
      "src/cocoa_platform.h",
      "src/egl_context.c",
      "src/wgl_context.c",
      "src/glx_context.c",
      "src/egl_context.h",
      "src/wgl_context.h",
      "src/glx_context.h"
    }

    defines
    {
      "_GLFW_COCOA"
    }

  filter "configurations:Debug*"
    defines "WZ_CONFIG_DEBUG"
    runtime "Debug"
    symbols "On"
    optimize "Off"

  filter "configurations:Release*"
    defines "WZ_CONFIG_RELEASE"
    runtime "Release"
    symbols "On"
    optimize "On"

  filter "configurations:Dist*"
    defines { "WZ_CONFIG_DIST", "WZ_DISABLE_ASSERTS" }
    runtime "Release"
    symbols "Off"
    optimize "Speed"
