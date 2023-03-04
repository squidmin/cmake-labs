# Topics

0. Create Source and CMakeFile
1. `mkdir build`
2. `cd build`
3. `cmake ..`   -  Generating the Build Files / Configure the Project
   - The `..` in the above command indicates that the directory one level above is the root directory, which contains the main `CMakeLists.txt`.
4. `cmake --build .`
   - Compile the main source file to an object file. Link the object file to an executable and build the executable.
5. `./Executable`
