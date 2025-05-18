find_package(GTest REQUIRED)

if(GTest_FOUND)
    message(WARNING " GTest already installed in your machine")
else()
    message(WARNING " GTest not found!!!!")
endif()
