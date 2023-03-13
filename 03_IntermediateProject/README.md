# Takeaways

If you have any subdirectories containing source files in your project, each of those subdirectories should contain a CMakeLists.txt file.

In the `/app` directory, define everything for the executable.

In the `/src` directory, define everything for the a given library.

If a project contains multiple libraries (e.g., compilation units), then multiple subdirectories will be contained in the `/src` directory.
