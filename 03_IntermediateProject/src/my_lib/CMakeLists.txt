add_library(Library STATIC my_lib.cc)

target_include_directories(Library PUBLIC "./")  # Header files are relatively located in the same directory.
