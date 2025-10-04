# Native Dependencies

This folder contains native libraries and dependencies for different platforms.

## Structure

```
libs/
├── windows/
│   ├── x86_64/          # Windows 64-bit libraries (.dll, .lib)
│   └── arm64/           # Windows ARM64 libraries
├── linux/
│   ├── x86_64/          # Linux 64-bit libraries (.so)
│   └── arm64/           # Linux ARM64 libraries
├── android/
│   ├── arm64/           # Android ARM64 libraries (.so, .aar)
│   └── x86_64/          # Android x86_64 libraries
├── ios/
│   └── arm64/           # iOS libraries (.a, .framework)
└── macos/
    └── arm64/           # macOS libraries (.dylib, .framework)
```

## Firebase Example

To add Firebase C++ SDK:

1. Download Firebase C++ SDK from https://firebase.google.com/docs/cpp/setup
2. Extract and place platform-specific libraries in appropriate folders:

### Windows
- `libs/windows/x86_64/firebase_app.lib`
- `libs/windows/x86_64/firebase_auth.lib`
- `libs/windows/x86_64/firebase_database.lib`
- `libs/windows/x86_64/firebase_storage.lib`

### Android
- `libs/android/arm64/libfirebase_app.so`
- `libs/android/arm64/libfirebase_auth.so`
- `libs/android/arm64/firebase_auth.aar`
- `libs/android/arm64/firebase_database.aar`

### iOS
- `libs/ios/arm64/libfirebase_app.a`
- `libs/ios/arm64/libfirebase_auth.a`

## Usage

The SConstruct file is configured to automatically link these libraries when building for each platform.

## Adding New Dependencies

1. Create platform-specific folders if they don't exist
2. Place library files in appropriate folders
3. Update SConstruct to link the new libraries
4. Update your C++ code to include the headers and use the libraries
