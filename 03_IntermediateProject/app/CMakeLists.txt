add_executable(Executable main.cc)

target_link_libraries(Executable PUBLIC Library)  # Library is a dependency of Executable.
