# Windows x86_64 Native Libraries

Place your Windows 64-bit native libraries here.

## File Types
- `.lib` - Static library files for linking
- `.dll` - Dynamic library files for runtime

## Example Files (Firebase C++ SDK)
```
firebase_app.lib
firebase_auth.lib
firebase_database.lib
firebase_storage.lib
```

## Example Files (Custom Library)
```
mylib.lib
mylib.dll
```

## Notes
- Library files will be automatically linked during compilation
- DLL files should be placed in the same directory as your GDExtension
- The build system will automatically detect and link `.lib` files
