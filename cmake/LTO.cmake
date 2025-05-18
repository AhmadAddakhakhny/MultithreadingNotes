# it is a good practice to check the support of LTO of your compiler
# and the following function does so.

function(target_enable_lto TARGET ENABLE)
    if(NOT ENABLE)
        return()
    endif()

    # if the used CMake version is old, consider to explicitly set the policy before calling check_ipo_supported()
    # Ensure policy CMP0069 is set explicitly (required before 3.20)
    if(POLICY CMP0069)
        cmake_policy(SET CMP0069 NEW)
    endif()

    # A standard cmake include provides methods to check whether IPO supported for the current running compiler
    include(CheckIPOSupported)
    check_ipo_supported(RESULT result OUTPUT output)

    if(result)
        message(STATUS "IPO/LTO is supported!")
        # This tells CMake: Set the INTERPROCEDURAL_OPTIMIZATION property of the target ${TARGET} to TRUE.
        # set_property(): it's a built-in cmake command
        set_property(
            TARGET ${TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE
        )# g++ -flto main.c utils.c -o myapp
    else()
        message(WARNING "IPO/LTO is not supported!")
    endif()
endfunction()
