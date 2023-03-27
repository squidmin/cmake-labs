# Git submodules

## External submodule subdirectory

Create the subdirectory to store the external dependencies.

All external dependencies added to the project should be stored in the `external` directory.

Use the dependency's GitHub repo URL with the `git submodule add` command.

```shell
git submodule add https://example.com/author/repo-name.git external/repo-name
```

e.g.,

```shell
git submodule add https://github.com/nlohmann/json.git external/json
```

The repository will be cloned into the path specified in the `git submodule add` command.

## The `.gitmodules` file

Git will create a file called `.gitmodules` in the `external` directory, which lists all submodules added via the `git submodule add` command.

---

## The `cmake` directory

From the root directory of the project, create another directory called `cmake`.

In a typical CMake project, this directory stores module (`.cmake`) files.

---

In the `cmake` directory, add a file called `AddGitSubmodule.cmake`:

### `AddGitSubmodule.cmake`

```cmake
function(add_git_submodule dir)  # dir denotes the relative path at the external directory level of the project.
    # Find the Git installation on the system (it must be ensured that Git is found on the system).
    find_package(Git REQUIRED)

    # If there is no CMakeLists.txt file located in the external directory that we have added...
    if (NOT EXISTS ${dir}/CMakeLists.txt)
        # Updates external dependencies.
        execute_process(COMMAND ${GIT_EXECUTABLE}  # GIT_EXECUTABLE is set by the find_package() function. It stores the absolute path to the Git executable found on the system.
            submodule update --init --recursive -- ${dir}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()

    add_subdirectory(${dir})  # Add the directories of the external dependencies.
endfunction(add_git_submodule)
```

- `dir` denotes the relative path at the external directory level of the project.
- `find_package(Git REQUIRED)` locates the Git installation on the host machine. An error is thrown if no Git installation is found.
- `if (NOT EXISTS ${dir}/CMakeLists.txt)`: Detect if there is any `CMakeLists.txt` file in the `external` directory.
- `GIT_EXECUTABLE`: Set by the `find_package()` function. It stores the absolute path to the Git executable found on the system.
- `add_subdirectory(${dir})`: Add the directories of the external dependencies.

---

## Include the `add_git_submodule()` CMake function in the main `CMakeLists.txt` file

In the main `CMakeLists.txt` file, after the setters, add the following lines:

```cmake
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/") # Stores the absolute path to where the .cmake module files are located.
include(AddGitSubmodule)  # Includes CMake module files (not CMakeLists.txt). Adds the AddGitSubmodule function in this case.

add_git_submodule(external/json)

...
add_subdirectory(external)
...
```

The full root-level `CMakeLists.txt` file will look as follows:

### `CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.16)

project(CppProjectTemplate VERSION 1.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(LIBRARY_NAME Library)
set(EXECUTABLE_NAME Executable)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/") # Stores the absolute path to where the .cmake module files are located
include(AddGitSubmodule)  # Includes CMake module files (not CMakeLists.txt). Adds the AddGitSubmodule function in this case.

add_git_submodule(external/json)

add_subdirectory(configured)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(app)
```

---

## Include the `nlohmann_json` target in `app/CMakeLists.txt`

Add the `nlohmann_json` dependency in the `target_link_libraries()` function call, in `app/CMakeLists.txt`:

```cmake
target_link_libraries(${EXECUTABLE_NAME} PUBLIC
    ${LIBRARY_NAME}
    nlohmann_json)
```

### `app/CMakeLists.txt`

```cmake
set(EXE_SOURCES "main.cc")  # Set the variable for the name of the executable.

add_executable(${EXECUTABLE_NAME} ${EXE_SOURCES})

target_link_libraries(${EXECUTABLE_NAME} PUBLIC
    ${LIBRARY_NAME}
    nlohmann_json)
```

---

## Call the `nlohmann_json` dependency in `main.cc`

### `main.cc`

```cpp
#include <iostream>

#include "nlohmann/json.hpp"

#include "my_lib.h"
#include "config.hpp"

int main()
{
    std::cout << project_name << std::endl;
    std::cout << project_version << std::endl;

    std::cout << "JSON library version: "
        << NLOHMANN_JSON_VERSION_MAJOR << "."
        << NLOHMANN_JSON_VERSION_MINOR << "."
        << NLOHMANN_JSON_VERSION_PATCH << std::endl;

    print_hello_world();

    return 0;
}
```
