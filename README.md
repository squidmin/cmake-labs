# cmake-labs

CMake learning labs.


## Software installation

<details>
<summary>Compiler setup</summary>

- XCode: <https://www.ics.uci.edu/~pattis/common/handouts/macclion/clang.html>
- Check versions:

  ```shell
  lldb --version
  clang --version
  clang++ --version
  ```

</details>


<details>
<summary>Brew</summary>

```shell
brew install git
brew install make
brew install cmake
brew install doxygen
brew install lcov
brew install gcovr
brew install ccache
```

</details>


<details>
<summary>Add VSCode extensions</summary>

- C/C++ Extension Pack (franneck94)
- C/C++ Config (franneck94)

**If you want to use your own set of VSCode extensions without installing the above extensions**:

Create a portable version of VSCode: <https://code.visualstudio.com/docs/editor/portable>

This will create a separate version of VSCode that is fully contained to one folder. This portable version can run an instance side-by-side with the version that is installed on the user's system with no crossover.
All extensions installed on this portable version will be confined to the `/data` folder (created when setting up a portable version) within the portable version.

</details>


<details>
<summary>Generate C++ config files</summary>

**View -> Command Palette... -> Generate C++ Config Files**

This will create a `.vscode` directory in the project containing the C++ config files.

</details>


---


## CMake Tutorial


### Generating a project

<details>
<summary>Expand</summary>

```bash
cmake [<options>] -S <path-to-source> -B <path-to-build>
```

Assuming that a `CMakeLists.txt` is in the root directory, you can generate a project like the following:

```bash
mkdir build
cd build
```

#### Option 1

```bash
cmake -S .. -B .
```

#### Option 2

```bash
cmake ..
```

Assuming that you have already built the CMake project, you can update the generated project:

```bash
cd build
cmake .
```

</details>


<details>
<summary>Generator for GCC and Clang</summary>

```bash
cd build
```

#### Option 1

```bash
cmake -S .. -B . -G "Unix Makefiles"
```

#### Option 2

```bash
cmake .. -G "Unix Makefiles"
```

</details>


<details>
<summary>Generator for MSVC</summary>

```bash
cd build
```

#### Option 1

```bash
cmake -S .. -B . -G "Visual Studio 16 2019"
```

#### Option 2

```bash
cmake .. -G "Visual Studio 16 2019"
```

</details>


<details>
<summary>Specify the Build Type</summary>

Per default, the standard type is in most cases the debug type.

If you want to generate the project in `Release` mode, set the `CMAKE_BUILD_TYPE`:

```bash
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```

</details>


<details>
<summary>Passing options</summary>

If you have set some options in the `CMakeLists.txt`, you can pass values in the command line:

```bash
cd build
cmake -DMY_OPTION=[ON|OFF] .. 
```

</details>


<details>
<summary>Specify the Build Target (Option 1)</summary>

The standard build command would build all created targets within the `CMakeLists.txt` file.
If you want to build a specific target, you can do so:

```bash
cd build
cmake --build . --target ExternalLibraries_Executable
```

The target `ExternalLibraries_Executable` is just an example of a possible target name.

> **Note**: All dependent targets will be built beforehand.

</details>


<details>
<summary>Specify the Build Target (Option 2)</summary>

Besides setting the target within the `cmake --build` command, you could also run the `Makefile` generated from the previous step.

If you want to build the `ExternalLibraries_Executable`, you could do the following.

```bash
cd build
make ExternalLibraries_Executable
```

> **Note**: When building a target, all dependencies of the target are also built.

</details>


<details>
<summary>Run the Executable</summary>

After generating the project and building a specific target, you might want to run the executable.

By default, the executable is stored in `build/5_ExternalLibraries/app/ExternalLibraries_Executable`, assuming that
- you are building the project `5_ExternalLibraries`;
- the main file of the executable is in the `/app` directory.

```bash
cd build
./bin/ExternalLibraries_Executable
```

</details>


---


## Different Linking Types

<details>
<summary>Syntax</summary>

```cmake
add_library(A ...)
add_library(B ...)
add_library(C ...)
```

</details>


### `PUBLIC`

<details>
<summary>Expand</summary>

```cmake
target_link_libraries(A PUBLIC B)
target_link_libraries(C PUBLIC A)
```

> When `A` links in `B` as `PUBLIC`, it says that `A` uses `B` in its implementation, and `B` is also used in `A`'s public API. Hence, `C` can use `B`, since `B` is part of the public API of `A`.

</details>


### `PRIVATE`

<details>
<summary>Expand</summary>

```cmake
target_link_libraries(A PRIVATE B)
target_link_libraries(C PRIVATE A)
```

When `A` links in `B` as `PRIVATE`, it is saying that `A` uses `B` in its
implementation, but `B` is not used in any part of `A`'s public API. Any code
that makes calls into `A` would not need to refer directly to anything from
`B`.

</details>


### `INTERFACE`

<details>
<summary>Expand</summary>

```cmake
add_library(D INTERFACE)
target_include_directories(D INTERFACE {CMAKE_CURRENT_SOURCE_DIR}/include)
```

In general, used for header-only libraries.

</details>


---


## Different Library Types

<details>
<summary>Library</summary>

A binary file that contains information about code.
A library cannot be executed on its own. An application utilizes a library.

</details>


<details>
<summary>Shared</summary>

- Linux: *.so
- MacOS: *.dylib
- Windows: *.dll

Shared libraries reduce the amount of code that is duplicated in each program that makes use of the library, keeping the binaries small.
Shared libraries will however have a small additional cost for the execution.
In general, the shared library is in the same directory as the executable.

</details>


<details>
<summary>Static</summary>

- Linux/MacOS: *.a
- Windows: *.lib

Static libraries increase the overall size of the binary, but it means that you don't need to carry along a copy of the library that is being used.
As the code is connected at compile time there are not any additional run-time loading costs.

</details>
