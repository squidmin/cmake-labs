# cmake-labs

CMake learning labs.

## Software installation

### Compiler setup

- XCode: <https://www.ics.uci.edu/~pattis/common/handouts/macclion/clang.html>
- Check versions:

  ```shell
  lldb --version
  clang --version
  clang++ --version
  ```

### Brew

```shell
brew install git
brew install make
brew install cmake
brew install doxygen
brew install lcov
brew install lcov
brew install gcovr
brew install ccache
```

### Add VSCode extensions

- C/C++ Extension Pack (franneck94)
- C/C++ Config (franneck94)

**If you want to use your own set of VSCode extensions without installing the above extensions**:

Create a portable version of VSCode: <https://code.visualstudio.com/docs/editor/portable>

This will create a separate version of VSCode that is fully contained to one folder. This portable version can run an instance side-by-side with the version that is installed on the user's system with no crossover.
All extensions installed on this portable version will be confined to the `/data` folder (created when setting up a portable version) within the portable version.

### Generate C++ Config Files

**View -> Command Palette... -> Generate C++ Config Files**

This will create a `.vscode` directory in the project containing the C++ config files.

---

## CMake Tutorial

### Generating a Project

```bash
cmake [<options>] -S <path-to-source> -B <path-to-build>
```

Assuming that a CMakeLists.txt is in the root directory, you can generate a project like the following.

```bash
mkdir build
cd build
cmake -S .. -B . # Option 1
cmake .. # Option 2
```

Assuming that you have already built the CMake project, you can update the generated project.

```bash
cd build
cmake .
```

### Generator for GCC and Clang

```bash
cd build
cmake -S .. -B . -G "Unix Makefiles" # Option 1
cmake .. -G "Unix Makefiles" # Option 2
```

### Generator for MSVC

```bash
cd build
cmake -S .. -B . -G "Visual Studio 16 2019" # Option 1
cmake .. -G "Visual Studio 16 2019" # Option 2
```

### Specify the Build Type

Per default, the standard type is in most cases the debug type.
If you want to generate the project, for example, in release mode you have to set the build type.

```bash
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```

### Passing Options

If you have set some options in the CMakeLists, you can pass values in the command line.

```bash
cd build
cmake -DMY_OPTION=[ON|OFF] .. 
```

### Specify the Build Target (Option 1)

The standard build command would build all created targets within the CMakeLists.
If you want to build a specific target, you can do so.

```bash
cd build
cmake --build . --target ExternalLibraries_Executable
```

The target *ExternalLibraries_Executable* is just an example of a possible target name.
Note: All dependent targets will be built beforehand.

### Specify the Build Target (Option 2)

Besides setting the target within the cmake build command, you could also run the previously generated Makefile (from the generating step).
If you want to build the *ExternalLibraries_Executable*, you could do the following.

```bash
cd build
make ExternalLibraries_Executable
```

#### Note

When building a target, all dependencies of the target are also built.

### Run the Executable

After generating the project and building a specific target you might want to run the executable.
In the default case, the executable is stored in *build/5_ExternalLibraries/app/ExternalLibraries_Executable*, assuming that you are building the project *5_ExternalLibraries* and the main file of the executable is in the *app* dir.

```bash
cd build
./bin/ExternalLibraries_Executable
```

### Different Linking Types

```cmake
add_library(A ...)
add_library(B ...)
add_library(C ...)
```

### `PUBLIC`

```cmake
target_link_libraries(A PUBLIC B)
target_link_libraries(C PUBLIC A)
```

When A links in B as *PUBLIC*, it says that A uses B in its implementation, and B is also used in A's public API. Hence, C can use B, since B is part of the public API of A.

### `PRIVATE`

```cmake
target_link_libraries(A PRIVATE B)
target_link_libraries(C PRIVATE A)
```

When A links in B as *PRIVATE*, it is saying that A uses B in its
implementation, but B is not used in any part of A's public API. Any code
that makes calls into A would not need to refer directly to anything from
B.

### `INTERFACE`

```cmake
add_library(D INTERFACE)
target_include_directories(D INTERFACE {CMAKE_CURRENT_SOURCE_DIR}/include)
```

In general, used for header-only libraries.

### Different Library Types

### Library

A binary file that contains information about code.  
A library cannot be executed on its own.  
An application utilizes a library.

### Shared

- Linux: *.so
- MacOS: *.dylib
- Windows: *.dll

Shared libraries reduce the amount of code that is duplicated in each program that makes use of the library, keeping the binaries small.  
Shared libraries will however have a small additional cost for the execution.  
In general the shared library is in the same directory as the executable.

### Static

- Linux/MacOS: *.a
- Windows: *.lib

Static libraries increase the overall size of the binary, but it means that you don't need to carry along a copy of the library that is being used.  
As the code is connected at compile time there are not any additional run-time loading costs.
