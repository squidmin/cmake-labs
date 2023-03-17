cmake_minimum_required(VERSION 3.16)

project(CppProjectTemplate VERSION 1.0.0 LANGUAGES C CXX)

# Set the default standard.
# If this isn't set to define a standard for certain targets, it becomes user-dependent which C++ standard is used by the compiler, which is not a good habit in modern C++ projects.
set(CMAKE_CXX_STANDARD 17)


set(CMAKE_CXX_STANDARD_REQUIRED ON)

# g++ and gcc compilers have some features that are not implemented in the C++ standard (e.g., variable-length arrays, which are known as "extensions").
set(CMAKE_CXX_EXTENSIONS OFF)

set(LIBRARY_NAME Library)  # Setting variable names for targets.
set(EXECUTABLE_NAME Executable)

option(COMPILE_EXECUTABLE "Whether to compile the executable" OFF)


add_subdirectory(src)

if (COMPILE_EXECUTABLE)
    add_subdirectory(app)
else()
    message("Without executable compiling...")  # Shown when configuring the project; not when building.
endif()
