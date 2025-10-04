#!/usr/bin/env python3

import os
import sys

# Get the path to the build script.
script_path = os.path.dirname(os.path.abspath(__file__))

# Import the build script.
sys.path.insert(0, script_path)
from methods import *

# Set the environment variables for the build.
env = Environment()

# Set the target platform.
if ARGUMENTS.get("target", "template_debug") == "template_release":
    env["target"] = "template_release"
else:
    env["target"] = "template_debug"

# Set the platform.
if ARGUMENTS.get("platform", "windows") == "linux":
    env["platform"] = "linux"
elif ARGUMENTS.get("platform", "windows") == "macos":
    env["platform"] = "macos"
elif ARGUMENTS.get("platform", "windows") == "android":
    env["platform"] = "android"
elif ARGUMENTS.get("platform", "windows") == "ios":
    env["platform"] = "ios"
elif ARGUMENTS.get("platform", "windows") == "web":
    env["platform"] = "web"
else:
    env["platform"] = "windows"

# Set the architecture.
if ARGUMENTS.get("arch", "x86_64") == "arm64":
    env["arch"] = "arm64"
else:
    env["arch"] = "x86_64"

# Set the Godot version.
env["godot_version"] = "4.5"

# Set the extension name.
env["extension_name"] = "myextension"

# Set the source directory.
env["source_dir"] = "src"

# Set the output directory.
env["output_dir"] = "project/addons/myextension/bin"

# Set the godot-cpp path
env["godot_cpp_path"] = "godot-cpp"

# Build the extension.
build_extension(env)
