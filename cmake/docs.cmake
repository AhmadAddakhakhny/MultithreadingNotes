find_package(Doxygen) # Check if Doxygen installed in your machine

if(DOXYGEN_FOUND
)# This variable is set to true if find_package() found the tool installed
    add_custom_target(
        # Creates a custom build target ==> cmake --build . --target docs  || make docs
        docs # named docs
        ${DOXYGEN_EXECUTABLE} # The full path of the Doxygen Binary
        WORKING_DIRECTORY
            ${CMAKE_SOURCE_DIR}/docs # The path of the doxygen config file
    )
endif()
