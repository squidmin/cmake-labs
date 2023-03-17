add_library(${LIBRARY_NAME} STATIC my_lib.cc)

target_include_directories(${LIBRARY_NAME} PUBLIC "./")  # Header files are relatively located in the same directory.
