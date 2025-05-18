set(TEST_DUMMY "test.exe")
set(TEST_SOURCES "unitTestDemo.cpp")
set(TEST_INCLUDES "./")

add_executable(${TEST_DUMMY} ${TEST_SOURCES})
target_include_directories(${TEST_DUMMY} PUBLIC ${TEST_INCLUDES})
target_link_libraries(${TEST_DUMMY} GTest::GTest GTest::Main)

set(COVERAGE_MAIN "coverage")
set(COVERAGE_EXCLUDES
    "${PROJECT_SOURCE_DIR}/app/*"
    "${PROJECT_SOURCE_DIR}/cmake/*"
    "${PROJECT_SOURCE_DIR}/docs/*"
    "${PROJECT_SOURCE_DIR}/external/*"
    "${PROJECT_SOURCE_DIR}/tests/*"
    "${PROJECT_SOURCE_DIR}/build/*"
    "/usr/include/*")
set(COVERAGE_EXTRA_FLAGS)
set(COVERAGE_DEPENDENCIES ${TEST_DUMMY})

setup_target_for_coverage_gcovr_html(
    NAME
    ${COVERAGE_MAIN}
    EXECUTABLE
    ${PROJECT_BINARY_DIR}/tests/test.exe
    DEPENDENCIES
    ${COVERAGE_DEPENDENCIES}
    BASE_DIRECTORY
    ${CMAKE_SOURCE_DIR})
