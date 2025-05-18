function(execBashCommand _cmd _outVar)
    execute_process(
        COMMAND bash -c "${_cmd}" # Tell bash execute the given command string
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE _result
        OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(${_outVar}
        "${_result}"
        PARENT_SCOPE) # PARENT_SCOPE: keep the value when function returns
endfunction()
