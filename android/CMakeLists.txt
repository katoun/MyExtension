# CMake configuration for Android native dependencies
# This file should be placed in your Android project's src/main/cpp/CMakeLists.txt

cmake_minimum_required(VERSION 3.22.1)

project("myextension")

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(PkgConfig REQUIRED)

# Firebase C++ SDK
set(FIREBASE_CPP_SDK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/android")
if(EXISTS "${FIREBASE_CPP_SDK_DIR}")
    set(FIREBASE_CPP_SDK_INCLUDE_DIR "${FIREBASE_CPP_SDK_DIR}/include")
    set(FIREBASE_CPP_SDK_LIB_DIR "${FIREBASE_CPP_SDK_DIR}/${ANDROID_ABI}")
    
    # Add Firebase include directories
    include_directories(${FIREBASE_CPP_SDK_INCLUDE_DIR})
    
    # Find Firebase libraries
    find_library(FIREBASE_APP_LIB firebase_app PATHS ${FIREBASE_CPP_SDK_LIB_DIR})
    find_library(FIREBASE_AUTH_LIB firebase_auth PATHS ${FIREBASE_CPP_SDK_LIB_DIR})
    find_library(FIREBASE_DATABASE_LIB firebase_database PATHS ${FIREBASE_CPP_SDK_LIB_DIR})
    
    if(FIREBASE_APP_LIB AND FIREBASE_AUTH_LIB AND FIREBASE_DATABASE_LIB)
        message(STATUS "Found Firebase libraries for ${ANDROID_ABI}")
        set(FIREBASE_LIBS ${FIREBASE_APP_LIB} ${FIREBASE_AUTH_LIB} ${FIREBASE_DATABASE_LIB})
    else()
        message(WARNING "Firebase libraries not found for ${ANDROID_ABI}")
        set(FIREBASE_LIBS "")
    endif()
else()
    message(WARNING "Firebase C++ SDK directory not found: ${FIREBASE_CPP_SDK_DIR}")
    set(FIREBASE_LIBS "")
endif()

# Add your GDExtension source files
set(SOURCES
    # Add your C++ source files here
    # firebase_wrapper.cpp
    # my_node.cpp
    # my_singleton.cpp
)

# Create the shared library
add_library(myextension SHARED ${SOURCES})

# Link libraries
target_link_libraries(myextension
    # Godot C++ bindings (if available)
    # godot-cpp
    
    # Firebase libraries
    ${FIREBASE_LIBS}
    
    # Android system libraries
    android
    log
    jnigraphics
)

# Compiler-specific options
target_compile_options(myextension PRIVATE
    -Wall
    -Wextra
    -Wno-unused-parameter
    -fno-rtti
    -fno-exceptions
)

# Include directories
target_include_directories(myextension PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${FIREBASE_CPP_SDK_INCLUDE_DIR}
)
