set(LIB_SOURCES "printHello.cpp")
set(LIB_HEADERS "printHello.hpp")

add_library(LIB STATIC ${LIB_SOURCES} ${LIB_HEADERS})
target_include_directories(LIB PUBLIC "./")
target_link_libraries(LIB PUBLIC nlohmann_json::nlohmann_json)

target_set_warnings(LIB ${WARNINGS_ENABLED} ${WARNINGS_ENABLED_AS_ERR})
target_enable_lto(LIB ${LTO_ENABLED})
if(${CLANG-TIDY_ENABLED})
    add_clang_tidy_to_target(LIB)
endif()
