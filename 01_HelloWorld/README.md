# Topics

1. Create source file (`.cc`, `.cpp`, `.cxx`, etc.) and `CMakeLists.txt` file
2. `mkdir build`
3. `cd build`
4. `cmake ..`
   - Generates the Build Files / Configures the Project
   - The `..` in the above command indicates that the directory one level above is the root directory, which contains the main `CMakeLists.txt`.
5. `cmake --build .`
   - Compiles the main source file to an object file. Links the object file to an executable and builds the executable.
6. `./Executable`
