set(APP_SOURCES "main.cpp")
add_executable(app.exe ${APP_SOURCES})

target_link_libraries(app.exe PUBLIC LIB)

# Target include files paths shall be passed to this function
target_include_directories(
    app.exe PRIVATE "${CMAKE_BINARY_DIR}/configured_files/include")
target_compile_definitions(app.exe PRIVATE DEBUG_LOG=$<BOOL:${DEBUG_LOG}>)
target_link_libraries(app.exe PRIVATE nlohmann_json)
target_set_warnings(app.exe ${WARNINGS_ENABLED} ${WARNINGS_ENABLED_AS_ERR})
target_enable_lto(app.exe ${LTO_ENABLED})

if(${CLANG-TIDY_ENABLED})
    add_clang_tidy_to_target(app.exe)
endif()
