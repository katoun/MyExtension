#!/usr/bin/env python
import os
from glob import glob
from pathlib import Path

# TODO: Do not copy environment after godot-cpp/test is updated <https://github.com/godotengine/godot-cpp/blob/master/test/SConstruct>.
env = SConscript("godot-cpp/SConstruct")

# Add source files.
env.Append(CPPPATH=["src/"])

# Add Firebase headers if available
firebase_include_path = f"libs/{env['platform']}/{env['arch']}/include"
if os.path.exists(firebase_include_path):
    env.Append(CPPPATH=[firebase_include_path])
    print(f"Added Firebase include path: {firebase_include_path}")

sources = Glob("src/*.cpp")

# Add native libraries support
def get_native_libs(env):
    """Get native libraries for the current platform and architecture."""
    platform = env["platform"]
    arch = env["arch"]
    
    # Define library paths based on platform
    lib_paths = {
        "windows": f"libs/windows/{arch}",
        "linux": f"libs/linux/{arch}",
        "android": f"libs/android/{arch}",
        "ios": f"libs/ios/{arch}",
        "macos": f"libs/macos/{arch}",
    }
    
    lib_path = lib_paths.get(platform)
    if not lib_path or not os.path.exists(lib_path):
        return []
    
    # Find all library files in the platform-specific directory
    lib_files = []
    for root, dirs, files in os.walk(lib_path):
        for file in files:
            if file.endswith(('.lib', '.a', '.so', '.dylib')):
                lib_files.append(os.path.join(root, file))
    
    return lib_files

# Get native libraries for current platform
native_libs = get_native_libs(env)
if native_libs:
    print(f"Found {len(native_libs)} native libraries for {env['platform']}/{env['arch']}")
    for lib in native_libs:
        print(f"  - {lib}")
    
    # Add library path to linker
    lib_dirs = set()
    for lib in native_libs:
        lib_dirs.add(os.path.dirname(lib))
    
    for lib_dir in lib_dirs:
        env.Append(LIBPATH=[lib_dir])
    
    # Add libraries to linker
    lib_names = []
    for lib in native_libs:
        lib_name = os.path.splitext(os.path.basename(lib))[0]
        # Remove 'lib' prefix if present (for Unix-style libraries)
        if lib_name.startswith('lib'):
            lib_name = lib_name[3:]
        lib_names.append(lib_name)
    
    env.Append(LIBS=lib_names)
    
    # Add Firebase-specific linker flags for Windows
    if env["platform"] == "windows" and any("firebase" in lib.lower() for lib in lib_names):
        env.Append(LINKFLAGS=["/FORCE:UNRESOLVED"])
        print("Added Firebase-specific linker flags for Windows")
else:
    print(f"No native libraries found for {env['platform']}/{env['arch']}")

# Find gdextension path even if the directory or extension is renamed (e.g. project/addons/example/example.gdextension).
(extension_path,) = glob("project/addons/*/*.gdextension")

# Get the addon path (e.g. project/addons/example).
addon_path = Path(extension_path).parent

# Get the project name from the gdextension file (e.g. example).
project_name = Path(extension_path).stem

scons_cache_path = os.environ.get("SCONS_CACHE")
if scons_cache_path != None:
    CacheDir(scons_cache_path)
    print("Scons cache enabled... (path: '" + scons_cache_path + "')")

# Create the library target (e.g. libexample.linux.debug.x86_64.so).
debug_or_release = "release" if env["target"] == "template_release" else "debug"
if env["platform"] == "macos":
    library = env.SharedLibrary(
        "{0}/bin/lib{1}.{2}.{3}.framework/{1}.{2}.{3}".format(
            addon_path,
            project_name,
            env["platform"],
            debug_or_release,
        ),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "{}/bin/lib{}.{}.{}.{}{}".format(
            addon_path,
            project_name,
            env["platform"],
            debug_or_release,
            env["arch"],
            env["SHLIBSUFFIX"],
        ),
        source=sources,
    )

Default(library)
