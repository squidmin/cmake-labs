function(add_git_submodule dir)
    find_package(Git REQUIRED)  # Find 'Git' installation on the computer. It must be ensured that 'Git' is found on your system.

    if (NOT EXISTS ${CMAKE_SOURCE_DIR}/${dir}/CMakeLists.txt)  # If there is no CMakeLists.txt file in this external directory that we have added.
        execute_process(COMMAND ${GIT_EXECUTABLE}  # GIT_EXECUTABLE is set by the find_package() function.
            submodule update --init --recursive -- ${CMAKE_SOURCE_DIR}/${dir}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()

    # add_subdirectory can only be called if the given directory contains a CMakeLists.txt file
    if (EXISTS ${CMAKE_SOURCE_DIR}/${dir}/CMakeLists.txt)
        message("Adding: ${dir}/CMakeLists.txt")
        add_subdirectory(${CMAKE_SOURCE_DIR}/${dir})
    else()
        message("Could not add: ${dir}/CMakeLists.txt")
    endif()
endfunction(add_git_submodule)
