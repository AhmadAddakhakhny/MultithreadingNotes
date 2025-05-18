function(add_sanitizer_flags)
    # Remark:
    # For extra explination of sanitizer compiler options, consider visting the following WIKI
    # provided by gcc.gnu  ->  https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html

    add_compile_options("-fno-omit-frame-pointer") # Improves stack traces.
    add_link_options("-fno-omit-frame-pointer")

    add_compile_options("-fsanitize=address"
    )# Detect out-of-bounds and use-after-free bugs.
    add_link_options("-fsanitize=address")

    add_compile_options("-fsanitize=undefined"
    )#  a fast undefined behavior detector.
    add_link_options("-fsanitize=undefined")

endfunction()
