function(add_clang_tidy_to_target target)
    get_target_property(TARGET_SOURCES ${target} SOURCES)
    list(
        FILTER
        TARGET_SOURCES
        INCLUDE
        REGEX
        ".*.(cc|h|cpp|hpp)")

    find_package(Python3 COMPONENTS Interpreter)
    if(NOT ${Python_FOUND})
        message(WARNING "Python3 needed for Clang-Tidy")
        return()
    endif()

    find_program(CLANGTIDY clang-tidy)
    if(CLANGTIDY)
        message(STATUS "Added Clang Tidy for Target: ${target}")
        add_custom_target(
            ${target}_clangtidy
            COMMAND
                ${Python3_EXECUTABLE}
                ${CMAKE_SOURCE_DIR}/tools/run-clang-tidy.py ${TARGET_SOURCES}
                CONFIG_FILE=${CMAKE_SOURCE_DIR}/.clang-tidy
                -extra-arg-before=-std=${CMAKE_CXX_STANDARD}
                # HEADER_FILTER=(src|app)/.*\\.(h|hpp)
                -header-filter=' (src|app) /.*\\. (h|hpp) '
                -p=${CMAKE_BINARY_DIR}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            USES_TERMINAL)
        message(STATUS "CMAKE_BINARY_DIR:  ${CMAKE_BINARY_DIR}")
    else()
        message(WARNING "CLANGTIDY NOT FOUND")
    endif()
endfunction()

function(add_clang_format_target)
    if(NOT ${ENABLE_CLANG_FORMAT})
        return()
    endif()

    find_package(Python3 COMPONENTS Interpreter)

    if(NOT ${Python_FOUND})
        return()
    endif()

    file(GLOB_RECURSE CMAKE_FILES_CC "*/*.cc")
    file(GLOB_RECURSE CMAKE_FILES_CPP "*/*.cpp")
    file(GLOB_RECURSE CMAKE_FILES_H "*/*.h")
    file(GLOB_RECURSE CMAKE_FILES_HPP "*/*.hpp")
    set(CPP_FILES
        ${CMAKE_FILES_CC}
        ${CMAKE_FILES_CPP}
        ${CMAKE_FILES_H}
        ${CMAKE_FILES_HPP})
    list(
        FILTER
        CPP_FILES
        EXCLUDE
        REGEX
        "${CMAKE_SOURCE_DIR}/(build|external)/.*")

    find_program(CLANGFORMAT clang-format)

    if(CLANGFORMAT)
        message(STATUS "Added Clang Format")
        string(
            REPLACE ";"
                    " "
                    CPP_FILES_STR
                    "${CPP_FILES}")
        set(DUMMY "")
        set(RUN_CMD
            "python3 ${CMAKE_SOURCE_DIR}/tools/run-clang-format.py ${CPP_FILES_STR} --in-place"
        )
        execbashcommand(${RUN_CMD} DUMMY)
    else()
        message(WARNING "CLANG FORMAT NOT FOUND")
    endif()
endfunction()

function(add_clang_format_diff_target)
    if(NOT ${ENABLE_CLANG_FORMAT})
        return()
    endif()

    find_package(Python3 COMPONENTS Interpreter)

    if(NOT ${Python_FOUND})
        return()
    endif()

    if(EXISTS "${CMAKE_SOURCE_DIR}/tools/run-clang-format-diff.py")
        message(STATUS "Added Clang Format diff")
        set(DUMMY "")
        set(RUN_CMD
            " git --no-pager diff -U0 --no-color --relative HEAD^ | ${Python3_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/run-clang-format-diff.py -p1 -i"
        )
        execbashcommand(${RUN_CMD} DUMMY)
    else()
        message(WARNING "CLANG FORMAT python script NOT FOUND")
    endif()
endfunction()

function(add_cmake_format_target)
    # Check if cmake-format is enabled
    if(NOT ${ENABLE_CMAKE_FORMAT})
        return()
    endif()

    # Define the root CMake file
    set(ROOT_CMAKE_FILES "${CMAKE_SOURCE_DIR}/CMakeLists.txt")

    # Gather all CMakeLists.txt files and .cmake files
    file(GLOB_RECURSE CMAKE_FILES_TXT "*/CMakeLists.txt")
    file(GLOB_RECURSE CMAKE_FILES_C "cmake/*.cmake")

    # Exclude build and external directories from the CMakeLists.txt list
    list(
        FILTER
        CMAKE_FILES_TXT
        EXCLUDE
        REGEX
        "${CMAKE_SOURCE_DIR}/(build|external)/.*")

    # Combine all CMake files to format
    set(CMAKE_FILES ${ROOT_CMAKE_FILES} ${CMAKE_FILES_TXT} ${CMAKE_FILES_C})

    # Check if cmake-format is installed
    find_program(CMAKE_FORMAT cmake-format)

    # If cmake-format is found, proceed with formatting
    if(CMAKE_FORMAT)
        message(STATUS "Found cmake-format. Adding format target.")

        # Build the cmake-format command list
        set(FORMATTING_COMMANDS)
        foreach(cmake_file ${CMAKE_FILES})
            list(
                APPEND
                FORMATTING_COMMANDS
                COMMAND
                cmake-format
                -c
                ${CMAKE_SOURCE_DIR}/.cmake-format.yaml
                -i
                ${cmake_file})
        endforeach()

        # Combine all formatting commands into a single string
        string(
            REPLACE ";"
                    " "
                    FORMATTING_COMMANDS_STR
                    "${CMAKE_FILES}")

        set(DUMMY)
        set(RUN_CMD "cmake-format ${FORMATTING_COMMANDS_STR} -i")
        execbashcommand(${RUN_CMD} DUMMY)
    else()
        message(
            WARNING
                "cmake-format not found. Please install it to format CMake files."
        )
    endif()
endfunction()
