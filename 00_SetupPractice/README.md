# Setup practice

## Introduction

This document contains a quickstart guide for setting up a modern CMake application.

Each step contains a code snippet for getting started.

---

## Create the `CMakeLists.txt` file in the root directory

```cmake
cmake_minimum_required(VERSION 3.16)

project(CppProjectTemplate VERSION 1.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_EXTENSIONS OFF)

set(LIBRARY_NAME Library)
set(EXECUTABLE_NAME Executable)

option(COMPILE_EXECUTABLE "Whether to compile the executable" OFF)

add_subdirectory(configured)
add_subdirectory(src)

if (COMPILE_EXECUTABLE)
    add_subdirectory(app)
endif()
```

---

## Basic project configuration

### Create a subdirectory to store the configuration files

```shell
mkdir configured
```

### Create a `config.hpp.in` file

```cpp
#pragma once

#include <cstdint>
#include <string_view>

static constexpr std::string_view project_name = "@PROJECT_NAME@";
static constexpr std::string_view project_version = "@PROJECT_VERSION@";

static constexpr std::int32_t project_version_major
{
    @PROJECT_VERSION_MAJOR@
};
static constexpr std::int32_t project_version_minor
{
    @PROJECT_VERSION_MINOR@
};
static constexpr std::int32_t project_version_patch
{
    @PROJECT_VERSION_PATCH@
};
```

### Create a `CMakeLists.txt` file in the configuration (`configured/`) directory

```cmake
configure_file(
    "config.hpp.in"
    "${CMAKE_BINARY_DIR}/configured_files/include/config.hpp" ESCAPE_QUOTES
)
```

---

## Create and configure a library

### Create a subdirectory to store the libraries' source code

```shell
mkdir src
```

### Create at least one subdirectory for specific library sources

```shell
cd src
mkdir my_lib
```

### Create boilerplate source code for the `my_lib` library

```shell
cd src/my_lib
touch my_lib.cc
touch my_lib.h
```

#### `my_lib.cc`

```cpp
#include <iostream>

#include "my_lib.h"

void print_hello_world()
{
    std::cout << "This is a sample library for testing boilerplate." << std::endl;
}
```

#### `my_lib.h`

```cpp
#pragma once

void print_hello_world();
```

### Create the `CMakeLists.txt` file in the library sources (`src/`) directory

```shell
cd src
touch CMakeLists.txt
```

#### `src/CMakeLists.txt`

```cmake
add_subdirectory(my_lib)
```

### Create a `CMakeLists.txt` file for the sample library (`my_lib`)

```shell
cd src/my_lib
touch CMakeLists.txt
```

#### `src/my_lib/CMakeLists.txt`

```cmake
add_library(${LIBRARY_NAME} STATIC my_lib.cc)

target_include_directories(
    ${LIBRARY_NAME} PUBLIC
    "./"
    "${CMAKE_BINARY_DIR}/configured_files/include"
)  # Header files are relatively located in the same directory.
```

---

## Create and configure application source code

### Create a subdirectory to store the application source code (`app/`)

```shell
mkdir app
```

### Create a main application sources (`app/main.cc`) file

```shell
cd app
touch main.cc
```

#### `app/main.cc`

```cpp
#include <iostream>

#include "my_lib.h"
#include "config.hpp"

int main()
{
    std::cout << project_name << std::endl;
    std::cout << project_version << std::endl;

    print_hello_world();

    return 0;
}
```

### Create the `CMakeLists.txt` file in the application sources (`app/`) directory

```shell
cd app
touch CMakeLists.txt
```

#### `app/CMakeLists.txt`

```cmake
add_executable(${EXECUTABLE_NAME} main.cc)

target_link_libraries(${EXECUTABLE_NAME} PUBLIC ${LIBRARY_NAME})  # Library is a dependency of Executable.
```
