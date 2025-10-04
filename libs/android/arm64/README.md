# Android ARM64 Native Libraries

Place your Android ARM64 native libraries here.

## File Types
- `.so` - Shared object files (native libraries)
- `.aar` - Android Archive files (can contain native libraries)

## Example Files (Firebase C++ SDK)
```
libfirebase_app.so
libfirebase_auth.so
libfirebase_database.so
libfirebase_storage.so
firebase_auth.aar
firebase_database.aar
```

## Example Files (Custom Library)
```
libmylib.so
mylib.aar
```

## Notes
- `.so` files will be automatically linked during compilation
- `.aar` files should be referenced in your Android Gradle build
- The build system will automatically detect and link `.so` files
- AAR files may contain additional Android-specific resources and Java code
