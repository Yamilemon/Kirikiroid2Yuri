cmake_minimum_required(VERSION 3.6)
project(krkr2yuri)
set(CMAKE_CXX_STANDARD 11)

add_subdirectory(${CMAKE_SOURCE_DIR}/src/core)
add_subdirectory(${CMAKE_SOURCE_DIR}/src/plugins)

add_library(${PROJECT_NAME} SHARED src/dummy.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC
    -Wl,-Bstatic
    krkr2core krkr2plugin
)