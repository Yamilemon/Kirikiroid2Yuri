cmake_minimum_required(VERSION 3.6)
project(krkr2plugin)
set(KRKR2PLUGIN_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(KRKR2CORE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../core)

# search kr2plugin src
file(GLOB KR2KR2PLUGIN_CODE
    ${KRKR2PLUGIN_PATH}/*.c
    ${KRKR2PLUGIN_PATH}/*.cpp
)
list(APPEND KR2KR2PLUGIN_CODE ${KRKR2PLUGIN_PATH}/ncbind/ncbind.cpp)

# make krkr2plugin
add_library(${PROJECT_NAME} STATIC ${KR2KR2PLUGIN_CODE})
target_include_directories(${PROJECT_NAME} PUBLIC
    ${KRKR2PLUGIN_PATH}
    ${KRKR2PLUGIN_PATH}/ncbind

    ${KRKR2CORE_PATH}
    ${KRKR2CORE_PATH}/tjs2
    ${KRKR2CORE_PATH}/environ
    ${KRKR2CORE_PATH}/msg
    ${KRKR2CORE_PATH}/msg/win32
    ${KRKR2CORE_PATH}/utils
    ${KRKR2CORE_PATH}/utils/win32
    ${KRKR2CORE_PATH}/base
    ${KRKR2CORE_PATH}/base/win32
    ${KRKR2CORE_PATH}/sound
    ${KRKR2CORE_PATH}/sound/win32
    ${KRKR2CORE_PATH}/visual
    ${KRKR2CORE_PATH}/visual/win32

    ${PORTBUILD_PATH}/include
)
target_compile_options(${PROJECT_NAME} PUBLIC 
    -fPIC -fexceptions -std=c++14 -fvisibility=hidden
)

target_compile_definitions(${PROJECT_NAME} PUBLIC
    -D__STDC_CONSTANT_MACROS -DTJS_TEXT_OUT_CRLF 
    -DTJS_TEXT_OUT_CRLF
)