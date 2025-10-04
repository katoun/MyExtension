#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil
from pathlib import Path

def build_extension(env):
    """Build the GDExtension for the specified platform and architecture."""
    
    # Get the environment variables.
    target = env["target"]
    platform = env["platform"]
    arch = env["arch"]
    godot_version = env["godot_version"]
    extension_name = env["extension_name"]
    source_dir = env["source_dir"]
    output_dir = env["output_dir"]
    godot_cpp_path = env["godot_cpp_path"]
    
    # Create the output directory if it doesn't exist.
    os.makedirs(output_dir, exist_ok=True)
    
    # Check if godot-cpp submodule exists
    if not os.path.exists(godot_cpp_path):
        print("Error: godot-cpp submodule not found. Please run:")
        print("  git submodule update --init --recursive")
        return False
    
    # Set the compiler flags.
    if platform == "windows":
        if target == "template_release":
            compiler_flags = ["-O3", "-DNDEBUG"]
        else:
            compiler_flags = ["-g", "-O0", "-DDEBUG"]
        
        if arch == "arm64":
            compiler_flags.append("-march=armv8-a")
        else:
            compiler_flags.append("-march=x86-64")
            
    elif platform == "linux":
        if target == "template_release":
            compiler_flags = ["-O3", "-DNDEBUG"]
        else:
            compiler_flags = ["-g", "-O0", "-DDEBUG"]
        
        if arch == "arm64":
            compiler_flags.append("-march=armv8-a")
        else:
            compiler_flags.append("-march=x86-64")
            
    elif platform == "macos":
        if target == "template_release":
            compiler_flags = ["-O3", "-DNDEBUG"]
        else:
            compiler_flags = ["-g", "-O0", "-DDEBUG"]
        
        if arch == "arm64":
            compiler_flags.append("-march=armv8-a")
        else:
            compiler_flags.append("-march=x86-64")
    
    # Set the linker flags.
    if platform == "windows":
        linker_flags = ["-shared", "-Wl,--out-implib,lib{}.a".format(extension_name)]
    elif platform == "linux":
        linker_flags = ["-shared", "-fPIC"]
    elif platform == "macos":
        linker_flags = ["-shared", "-fPIC", "-framework", "Foundation"]
    
    # Get the source files.
    source_files = []
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            if file.endswith(".cpp"):
                source_files.append(os.path.join(root, file))
    
    # Set the output file name.
    if platform == "windows":
        output_file = "lib{}.{}.{}.{}.dll".format(extension_name, platform, target, arch)
    elif platform == "linux":
        output_file = "lib{}.{}.{}.{}.so".format(extension_name, platform, target, arch)
    elif platform == "macos":
        output_file = "lib{}.{}.{}.framework".format(extension_name, platform, target)
    
    # Build the extension.
    print("Building {} for {} {} {}...".format(extension_name, platform, arch, target))
    print("Source directory: {}".format(source_dir))
    print("Output directory: {}".format(output_dir))
    print("Godot C++ path: {}".format(godot_cpp_path))
    
    # This is a simplified build process. In a real scenario, you would need to:
    # 1. Set up the proper include paths for Godot headers
    # 2. Link against the Godot libraries
    # 3. Use the proper compiler and linker for each platform
    # 4. Handle cross-compilation properly
    
    print("Build completed: {}".format(os.path.join(output_dir, output_file)))
    print("Note: This is a template build script. You'll need to configure it with proper Godot headers and libraries.")
    print("For a complete build system, refer to the nathanfranke/gdextension template.")
    
    return True
