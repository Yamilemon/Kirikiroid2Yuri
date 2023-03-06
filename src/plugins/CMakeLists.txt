cmake_minimum_required(VERSION 3.6)
project(krkr2plugin)

# search kr2plugin src
set(KRKR2PLUGIN_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/plugins)
file(GLOB KR2KR2PLUGIN_CODE
    "${KRKR2PLUGIN_PATH}/*.c"
    "${KRKR2PLUGIN_PATH}/*.cpp"
)
list(APPEND KR2KR2PLUGIN_CODE ${KRKR2PLUGIN_PATH}/ncbind/ncbind.cpp)

# make krkr2plugin
add_library(${PROJECT_NAME} STATIC ${KR2KR2PLUGIN_CODE})
target_compile_options(${PROJECT_NAME} PUBLIC 
    -fexceptions -std=c++14 -fvisibility=hidden
)
target_compile_definitions(${PROJECT_NAME} PUBLIC
    -D__STDC_CONSTANT_MACROS -DTJS_TEXT_OUT_CRLF 
    -DTJS_TEXT_OUT_CRLF
)
target_link_libraries(${PROJECT_NAME} PUBLIC krkr2core)