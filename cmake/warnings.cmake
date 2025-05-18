function(
    target_set_warnings
    _target
    _enable_warnings
    _enable_as_error)

    if(NOT ${_enable_warnings})
        return()
    endif()

    set(WARNINGS_FLAGS -Wall -Wextra -Wpedantic)

    if(${_enable_as_error})
        set(WARNINGS ${WARNINGS_FLAGS} -Werror)
    endif()

    target_compile_options(${_target} PRIVATE ${WARNINGS})
    message(STATUS "Compile ${_target} with the following warnings ${WARNINGS}")
endfunction()
