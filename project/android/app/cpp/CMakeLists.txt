cmake_minimum_required(VERSION 3.7)

set(KRKR2YURI_DIR ${CMAKE_SOURCE_DIR}/../../../..)
if(${ANDROID_ABI} MATCHES "arm64-v8a")
    set(PORTBUILD_PATH ${KRKR2YURI_DIR}/thirdparty/build/arch_androida64)
endif()

add_subdirectory(${KRKR2YURI_DIR} ${ONSYURI_DIR}/build_android)