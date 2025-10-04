# MyExtension - GDExtension for Godot 4.5

This is a GDExtension project for Godot 4.5 that demonstrates how to create custom C++ classes that can be used in Godot. Based on the [nathanfranke/gdextension](https://github.com/nathanfranke/gdextension) template structure.

## Project Structure

```
MyExtention/
├── .github/workflows/      # GitHub Actions for automated building
├── .gitmodules            # Git submodules configuration
├── .gitignore             # Git ignore rules
├── SConstruct             # Build script (nathanfranke template)
├── VERSION                # Version management file
├── LICENSE                # MIT License
├── src/                   # C++ source code
│   ├── register_types.cpp # Module registration
│   ├── register_types.h   # Registration header
│   ├── my_node.cpp        # MyNode class implementation
│   ├── my_node.hpp        # MyNode class header
│   ├── my_singleton.cpp   # MySingleton class implementation
│   ├── my_singleton.hpp   # MySingleton class header
│   ├── firebase_wrapper.cpp # Firebase integration wrapper
│   ├── firebase_wrapper.hpp # Firebase integration header
│   ├── firebase_app_options.cpp # FirebaseAppOptions class implementation
│   ├── firebase_app_options.hpp # FirebaseAppOptions class header
│   ├── firebase_app_options_resource.cpp # FirebaseAppOptionsResource class implementation
│   └── firebase_app_options_resource.hpp # FirebaseAppOptionsResource class header
├── project/               # Godot project for testing
│   ├── project.godot      # Project configuration
│   ├── icon.svg           # Project icon
│   ├── config/            # Firebase configuration files (game-specific)
│   │   ├── firebase_config.tres      # Default configuration
│   │   ├── firebase_config_dev.tres  # Development configuration
│   │   └── firebase_config_prod.tres # Production configuration
│   ├── addons/myextension/ # Extension files
│   │   ├── myextension.gdextension
│   │   ├── plugin.cfg     # Plugin metadata
│   │   └── bin/           # Compiled binaries (generated)
│   └── demo/              # Demo scenes and scripts
│       ├── test.tscn
│       └── test.gd
├── libs/                  # Native dependencies (Firebase, etc.)
│   ├── windows/x86_64/    # Windows 64-bit libraries
│   ├── linux/x86_64/      # Linux 64-bit libraries
│   ├── android/arm64/     # Android ARM64 libraries
│   └── ...                # Other platforms
├── godot-cpp/             # Godot C++ bindings (submodule)
├── build.bat              # Simple, reliable build script
├── setup-firebase.bat     # Download and setup Firebase C++ SDK
├── test-extension.bat     # Test extension in Godot (requires Godot 4.5)
├── download-godot.bat     # Download Godot 4.5 for testing
├── package-extension.bat  # Create distribution package
├── set-version.bat        # Update version across files
├── show-version.bat       # Display current version
├── update-entry-symbol.bat # Helper for unique entry symbols
├── NATIVE_DEPENDENCIES.md # Native dependencies integration guide
└── README.md              # This file
```

## Features

The extension provides three main classes:

### MyNode Class
- `hello_node()` - Returns a greeting message
- Inherits from Node with `_ready()` and `_process()` methods
- Can be added to scenes and used like any other Node

### MySingleton Class
- `hello_singleton(label)` - Updates a Label with greeting text
- Registered as a singleton accessible from anywhere in the project
- Available as `MySingleton` in GDScript

### FirebaseWrapper Class (Singleton)
- **Firebase Integration**: Complete Firebase C++ SDK wrapper for Godot
- **Singleton Pattern**: Available globally as `Firebase` singleton (like Unity Firebase SDK)
- **Clean Design**: Uses `FirebaseAppOptions` class for configuration, separating concerns
- **Authentication**: Anonymous, email/password sign-in and sign-up
- **Database**: Real-time database operations (set, get, delete)
- **Storage**: File upload/download capabilities
- **Cross-platform**: Works on Windows, Linux, Android, iOS, macOS
- **Native Dependencies**: Automatically links Firebase libraries

### FirebaseAppOptions Class
- **Configuration Class**: Dedicated class for Firebase configuration (Unity-like approach)
- **Type Safety**: Full Godot type system integration with proper property binding
- **Validation**: Built-in `is_valid()` method to check required fields
- **Utility Methods**: `set_defaults()` and `to_string()` for convenience
- **Reusable**: Can be created once and reused across different Firebase instances
- **Inspector Support**: Properties can be set in the Godot inspector

### FirebaseAppOptionsResource Class
- **Resource Class**: Extends Godot's Resource class for persistent configuration
- **Game-Specific Configuration**: Save and load Firebase configuration from `.tres` files in your project's `config/` folder
- **Environment Support**: Different configurations for dev/staging/production
- **Build Integration**: Configuration files are included in the build
- **Security**: Keep sensitive API keys in resource files, not in code
- **Conversion**: `to_firebase_app_options()` method converts to runtime options
- **Project Isolation**: Each game/project has its own Firebase configuration

## Getting Started

### Firebase Configuration Setup

1. **Create Configuration Directory**: Create a `config/` folder in your project root
2. **Create Configuration Files**: Create `.tres` files for different environments:
   - `config/firebase_config.tres` - Default configuration
   - `config/firebase_config_dev.tres` - Development environment
   - `config/firebase_config_prod.tres` - Production environment
3. **Configure Firebase Settings**: Edit the `.tres` files with your Firebase project details
4. **Load Configuration**: Use `load("res://config/firebase_config.tres")` in your code

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

4. **Setup Firebase C++ SDK (optional):**
   ```batch
   # Download and setup Firebase C++ SDK automatically
   setup-firebase.bat
   ```
   This will download the Firebase C++ SDK and place the necessary libraries and headers in the correct directories for automatic linking.

5. **Build the extension:**
   
   **Windows (Easy way):**
   ```batch
   # Interactive build menu with options
   build.bat
   ```
   
   **Manual build:**
   ```bash
   # Debug build for current platform
   scons
   
   # Or specify platform and target
   scons target=template_debug platform=windows arch=x86_64
   scons target=template_release platform=windows arch=x86_64
   ```

6. **Test the extension:**
   
   **Windows (Easy way):**
   ```batch
   # Test the extension (automatically downloads Godot 4.5 if needed)
   test-extension.bat
   ```
   
   **Manual download (optional):**
   ```batch
   # Download Godot 4.5 manually first
   download-godot.bat
   
   # Then test the extension
   test-extension.bat
   ```
   
   **Manual testing:**
   ```bash
   # Import and run the test project
   godot --path project/ --import
   godot --path project/
   ```
   
   **Note:** The `test-extension.bat` script now uses a locally downloaded Godot executable for isolated testing. The `godot-cpp` submodule only contains C++ bindings, not the Godot executable.

## Usage

### In Your Own Project

1. **Copy the extension files:**
   - Copy `project/addons/myextension/` to your Godot project's `addons/` directory
   - Enable the extension in Project Settings → Plugins

2. **Use in GDScript:**
   ```gdscript
   extends Node
   
   func _ready():
       # Use MyNode class
       var my_node = MyNode.new()
       add_child(my_node)
       print(my_node.hello_node())
       
       # Use MySingleton class
       MySingleton.hello_singleton($Label)
       
       # Use Firebase singleton (after setup-firebase.bat)
       
       # Method 1: Initialize with default options
       Firebase.initialize()
       
       # Method 2: Initialize with custom FirebaseAppOptions (clean, separated approach)
       var options = FirebaseAppOptions.new()
       options.project_id = "my-firebase-project"
       options.app_id = "1:123456789:android:abcdef123456"
       options.api_key = "AIzaSyYourApiKeyHere"
       options.storage_bucket = "my-firebase-project.appspot.com"
       options.auth_domain = "my-firebase-project.firebaseapp.com"
       options.database_url = "https://my-firebase-project-default-rtdb.firebaseio.com/"
       options.enable_auth = true
       options.enable_database = true
       options.enable_analytics = true
       options.enable_storage = true
       options.enable_messaging = true
       options.enable_remote_config = true
       options.enable_firestore = true
       
       # Validate and initialize
       if options.is_valid():
           Firebase.initialize_with_options(options)
       else:
           print("Invalid Firebase options!")
       
       # Use Firebase services
       Firebase.sign_in_anonymously()
       Firebase.set_database_value("users/123", {"name": "John Doe"})
       
       # Check authentication status
       if Firebase.is_signed_in():
           print("User ID: ", Firebase.get_user_id())
       
       # Method 3: Load configuration from resource file (recommended for production)
       var config_resource = load("res://config/firebase_config.tres")
       if config_resource and config_resource is FirebaseAppOptionsResource:
           var resource_options = config_resource.to_firebase_app_options()
           if resource_options.is_valid():
               Firebase.initialize_with_options(resource_options)
       
       # Method 4: Environment-specific configurations
       var environment = "dev"  # or "prod" based on your build
       var config_path = "res://config/firebase_config_" + environment + ".tres"
       var env_config = load(config_path)
       if env_config and env_config is FirebaseAppOptionsResource:
           var env_options = env_config.to_firebase_app_options()
           Firebase.initialize_with_options(env_options)
   ```

### Testing the Demo

Run the included demo project to see the extension in action:

```bash
godot --path project/ --editor
```

Then open and run the `demo/test.tscn` scene to test MyNode, MySingleton, and Firebase classes.

The test scene will:
- Check if MyNode class is available in the ClassDB
- Create a MyNode instance and test its methods
- Test MySingleton availability and functionality
- Test Firebase singleton availability and functionality
- Test Firebase initialization, authentication, and database operations
- Display results in the scene UI

## Windows Build Scripts

This project includes convenient Windows batch files for easy building and testing:

### `build.bat`
- **Purpose**: Simple, reliable build script
- **Features**:
  - Builds debug version for Windows x86_64
  - Works in both PowerShell and Command Prompt
  - No interactive menu - just builds and shows results
  - Error checking and validation
  - Uses proper SCons commands for building

### `test-extension.bat`
- **Purpose**: Automatically build and test the extension in Godot
- **Features**:
  - Checks if extension is built (builds if needed using SCons)
  - Finds Godot installation automatically
  - Imports and opens the demo project
  - Provides testing instructions

### `package-extension.bat`
- **Purpose**: Create distribution package for Godot Asset Library
- **Features**:
  - Builds all platform targets if needed
  - Creates properly formatted ZIP file
  - Includes all required files (binaries, config, plugin.cfg)
  - Ready for Asset Library submission
  - Automatically uses version from VERSION file

### `set-version.bat`
- **Purpose**: Update version number across all files
- **Features**:
  - Updates VERSION file
  - Updates plugin.cfg with new version
  - Centralized version management
  - Quick version updates

### `show-version.bat`
- **Purpose**: Display current version information
- **Features**:
  - Shows version from VERSION file
  - Shows version from plugin.cfg
  - Quick version check

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

#### **For Godot Asset Library:**

1. **Update version (if needed):**
   ```batch
   set-version.bat
   # Enter new version (e.g., 1.0.1)
   ```

2. **Build the extension:**
   ```batch
   build.bat
   # Builds debug version for Windows x86_64
   ```

3. **Create distribution package:**
   ```batch
   package-extension.bat
   # Automatically uses version from VERSION file
   ```

4. **Test the package:**
   - Extract the ZIP into a test Godot project
   - Verify the addon appears in Project Settings → Plugins
   - Test functionality

5. **Submit to Asset Library:**
   - Go to [Godot Asset Library](https://godotengine.org/asset-library/)
   - Create account and submit your addon
   - Upload the ZIP file
   - Fill in metadata (name, description, tags, etc.)

#### **For GitHub Releases:**

1. Push your code to GitHub
2. Go to Repository → Actions and download the latest artifact
3. Test the artifact by extracting the addon into a project
4. Create a new release on GitHub, uploading the artifact as an asset
5. Users can download directly from GitHub releases

## Troubleshooting

### Build Scripts
- **Any Terminal**: Use `build.bat` (works in PowerShell and Command Prompt)
- **Manual**: Run `scons target=template_debug platform=windows arch=x86_64`
- **Other targets**: Run `scons target=template_release platform=windows arch=x86_64`

### Troubleshooting
If you encounter any build issues:
1. **Check SCons**: Run `scons --version` to verify installation
2. **Check submodules**: Run `git submodule update --init --recursive`
3. **Manual build**: Use direct SCons commands if scripts fail

## Notes

- Based on the excellent [nathanfranke/gdextension](https://github.com/nathanfranke/gdextension) template
- Uses Godot C++ bindings as a submodule for better version management
- The extension is set to be reloadable for development convenience
- Minimum supported Godot version is 4.5
- The build system is configured for the nathanfranke template structure
- Uses unique entry symbol `myextension_gdextension_init` to avoid conflicts with other GDExtensions

## License

This project is provided as an example. Modify and use as needed for your projects.
