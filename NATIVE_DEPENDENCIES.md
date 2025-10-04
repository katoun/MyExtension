# Native Dependencies Integration Guide

This guide explains how to add native dependencies (like Firebase) to your GDExtension project.

## Overview

GDExtensions can include native libraries for different platforms:
- **Windows**: `.dll` and `.lib` files
- **Linux**: `.so` files
- **Android**: `.so` files and `.aar` files
- **iOS**: `.a` and `.framework` files
- **macOS**: `.dylib` and `.framework` files

## Directory Structure

```
libs/
├── windows/
│   ├── x86_64/          # Windows 64-bit libraries
│   └── arm64/           # Windows ARM64 libraries
├── linux/
│   ├── x86_64/          # Linux 64-bit libraries
│   └── arm64/           # Linux ARM64 libraries
├── android/
│   ├── arm64/           # Android ARM64 libraries
│   └── x86_64/          # Android x86_64 libraries
├── ios/
│   └── arm64/           # iOS libraries
└── macos/
    └── arm64/           # macOS libraries
```

## Adding Firebase C++ SDK

### 1. Download Firebase C++ SDK

1. Go to [Firebase C++ SDK](https://firebase.google.com/docs/cpp/setup)
2. Download the latest version
3. Extract the SDK

### 2. Platform-Specific Setup

#### Windows
Place these files in `libs/windows/x86_64/`:
```
firebase_app.lib
firebase_auth.lib
firebase_database.lib
firebase_storage.lib
```

#### Linux
Place these files in `libs/linux/x86_64/`:
```
libfirebase_app.so
libfirebase_auth.so
libfirebase_database.so
libfirebase_storage.so
```

#### Android
Place these files in `libs/android/arm64/`:
```
libfirebase_app.so
libfirebase_auth.so
libfirebase_database.so
firebase_auth.aar
firebase_database.aar
```

### 3. Update Your C++ Code

Include Firebase headers in your source files:
```cpp
#include "firebase/app.h"
#include "firebase/auth.h"
#include "firebase/database.h"
```

### 4. Build Configuration

The `SConstruct` file automatically detects and links native libraries. No additional configuration needed.

## Android-Specific Configuration

### 1. Gradle Configuration

Add to your `android/app/build.gradle`:
```gradle
dependencies {
    implementation 'com.google.firebase:firebase-bom:32.7.0'
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-database'
}
```

### 2. CMake Configuration

Use the provided `android/CMakeLists.txt` as a template for your Android project.

### 3. AAR Files

For Android, you can also use AAR (Android Archive) files:
1. Place `.aar` files in `libs/android/arm64/`
2. Reference them in your Gradle build file
3. The native `.so` files will be automatically extracted

## Using the Firebase Wrapper

The project includes a `FirebaseWrapper` class that provides a Godot-friendly interface to Firebase:

```gdscript
# In GDScript
var firebase = FirebaseWrapper.new()

# Initialize Firebase
if firebase.initialize():
    print("Firebase initialized successfully")

# Sign in anonymously
firebase.sign_in_anonymously()

# Connect to signals
firebase.auth_state_changed.connect(_on_auth_changed)
firebase.database_value_changed.connect(_on_data_changed)

# Use database
firebase.set_database_value("users/123", {"name": "John", "age": 30})
```

## Adding Other Native Dependencies

### 1. Library Files

Place your native library files in the appropriate platform directories:
- **Windows**: `.lib` files for linking, `.dll` files for runtime
- **Linux**: `.so` files
- **Android**: `.so` files and optionally `.aar` files
- **iOS**: `.a` files
- **macOS**: `.dylib` files

### 2. Headers

Place header files in a common location and add to your C++ includes:
```cpp
#include "your_library/header.h"
```

### 3. Build System

The `SConstruct` file automatically:
- Detects library files in platform-specific directories
- Adds library paths to the linker
- Links the libraries during compilation

## Troubleshooting

### Common Issues

1. **Library not found**: Ensure library files are in the correct platform/architecture directory
2. **Linker errors**: Check that library names match (without `lib` prefix for Unix)
3. **Runtime errors**: Ensure `.dll` files are in the same directory as your GDExtension
4. **Android build failures**: Check that AAR files are properly configured in Gradle

### Debugging

Enable verbose output in SConstruct to see which libraries are being linked:
```python
# The build system will print found libraries
print(f"Found {len(native_libs)} native libraries for {env['platform']}/{env['arch']}")
```

## Example: Adding a Custom Native Library

1. **Download/compile your library** for each target platform
2. **Place files** in appropriate `libs/platform/arch/` directories
3. **Include headers** in your C++ code
4. **Build** - the system will automatically link the libraries

Example structure for a custom library:
```
libs/
├── windows/x86_64/
│   ├── mylib.lib
│   └── mylib.dll
├── linux/x86_64/
│   └── libmylib.so
└── android/arm64/
    └── libmylib.so
```

## Best Practices

1. **Version Management**: Keep track of library versions
2. **Platform Testing**: Test on all target platforms
3. **Documentation**: Document any special setup requirements
4. **Licensing**: Ensure you comply with library licenses
5. **Size Optimization**: Only include libraries you actually use

## Distribution

When distributing your GDExtension:
1. Include all native library files in your package
2. Ensure libraries are in the correct platform directories
3. Test on clean systems to verify all dependencies are included
4. Consider using the `package-extension.bat` script for automated packaging
