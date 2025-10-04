# MyExtension - GDExtension for Godot 4.5

This is a GDExtension project for Godot 4.5 that demonstrates how to create custom C++ classes that can be used in Godot. Based on the [nathanfranke/gdextension](https://github.com/nathanfranke/gdextension) template structure.

## Project Structure

```
MyExtention/
├── .github/workflows/      # GitHub Actions for automated building
├── .gitmodules            # Git submodules configuration
├── .gitignore             # Git ignore rules
├── SConstruct             # Build script
├── methods.py             # Build methods
├── src/                   # C++ source code
│   ├── register_types.cpp # Module registration
│   ├── register_types.h   # Registration header
│   ├── my_extension.cpp   # Main extension implementation
│   └── my_extension.h     # Extension header
├── project/               # Godot project for testing
│   ├── project.godot      # Project configuration
│   ├── addons/myextension/ # Extension files
│   │   ├── myextension.gdextension
│   │   └── bin/           # Compiled binaries (generated)
│   └── demo/              # Demo scenes and scripts
│       ├── main.tscn
│       └── main.gd
├── godot-cpp/             # Godot C++ bindings (submodule)
└── README.md              # This file
```

## Features

The extension provides a `MyExtension` class with the following methods:
- `say_hello()` - Prints a greeting message
- `add_numbers(a, b)` - Adds two integers and returns the result
- `get_extension_info()` - Returns information about the extension

## Getting Started

### Prerequisites

1. **Godot 4.5** - Download from [godotengine.org](https://godotengine.org)
2. **Git** - For managing submodules
3. **C++ compiler** - GCC, Clang, or MSVC depending on your platform
4. **Python 3** - For the SCons build system
5. **SCons** - Build system (`pip install scons`)

### Setup Instructions

1. **Clone with submodules:**
   ```bash
   git clone --recurse-submodules https://github.com/yourusername/MyExtention.git
   cd MyExtention
   ```

2. **Or initialize submodules for existing repository:**
   ```bash
   git submodule update --init --recursive
   ```

3. **Update to latest godot-cpp:**
   ```bash
   git submodule update --remote
   ```

4. **Build the extension:**
   ```bash
   # Debug build for current platform
   scons
   
   # Or specify platform and target
   scons target=template_debug platform=windows arch=x86_64
   scons target=template_release platform=windows arch=x86_64
   ```

5. **Test the extension:**
   ```bash
   # Import and run the test project
   godot --path project/ --import
   godot --path project/
   ```

## Usage

### In Your Own Project

1. **Copy the extension files:**
   - Copy `project/addons/myextension/` to your Godot project's `addons/` directory
   - Enable the extension in Project Settings → Plugins

2. **Use in GDScript:**
   ```gdscript
   extends Node
   
   func _ready():
       var my_extension = MyExtension.new()
       add_child(my_extension)
       
       my_extension.say_hello()
       var result = my_extension.add_numbers(5, 3)
       print("Result: ", result)
   ```

### Testing the Demo

Run the included demo project to see the extension in action:

```bash
godot --path project/ --editor
```

Then open and run the `demo/main.tscn` scene.

## Platform Support

This extension is configured to support:
- Windows (x86_64, ARM64)
- Linux (x86_64, ARM64)
- macOS (Universal)
- Android (x86_64, ARM64)
- iOS (Universal)
- Web (WASM32)

## Automated Building with GitHub Actions

This project includes GitHub Actions workflows that automatically build the extension for multiple platforms:

- **Windows** (x86_64, ARM64) - Debug and Release
- **Linux** (x86_64, ARM64) - Debug and Release

The workflows create a packaged addon that can be distributed via the Godot Asset Library.

### Distributing Your Extension

1. Push your code to GitHub
2. Go to Repository → Actions and download the latest artifact
3. Test the artifact by extracting the addon into a project
4. Create a new release on GitHub, uploading the artifact as an asset
5. Submit to the Godot Asset Library using the release URL

## Notes

- Based on the excellent [nathanfranke/gdextension](https://github.com/nathanfranke/gdextension) template
- Uses Godot C++ bindings as a submodule for better version management
- The extension is set to be reloadable for development convenience
- Minimum supported Godot version is 4.5
- The build system is configured for the nathanfranke template structure

## License

This project is provided as an example. Modify and use as needed for your projects.
