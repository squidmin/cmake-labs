# Variables and options

Notice that the `/app` subdirectory is excluded from the CMake project by default:

```cmake
option(COMPILE_EXECUTABLE "Whether to compile the executable" OFF)
```

This setting can be overridden at the command line when building the project:

```shell
cd build
cmake .. -DCOMPILE_EXECUTABLE=ON
```

Now when using `cmake build .` in the `/build` directory, the project will include the `/app` directory and compile the executable.

This is just one example of how to utilize CMake options.
