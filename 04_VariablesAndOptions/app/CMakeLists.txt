add_executable(${EXECUTABLE_NAME} main.cc)

target_link_libraries(${EXECUTABLE_NAME} PUBLIC ${LIBRARY_NAME})  # Library is a dependency of Executable.
