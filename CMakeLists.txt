cmake_minimum_required(VERSION 3.6)
project(krkr2yuri)

option(PORTBUILD_PATH "use this value for thirdparty sysroot")
set(CMAKE_CXX_STANDARD 11)
set(KRKR2CORE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/core)
set(KRKR2PLUGIN_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/plugins)
set(COCOS2DX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/port/cocos2d-x)

# build library
add_subdirectory(${KRKR2CORE_PATH})
add_subdirectory(${KRKR2PLUGIN_PATH})

# build main
if(CMAKE_SYSTEM_NAME MATCHES "Android")
    add_library(${PROJECT_NAME} SHARED 
        project/android/app/cpp/krkr2_android.cpp
    )
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    message("${CMAKE_SYSTEM_NAME} not support yet")
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    message("${CMAKE_SYSTEM_NAME} not support yet")
else()
    message("${CMAKE_SYSTEM_NAME} not support yet")
endif()
target_compile_options(${PROJECT_NAME} PUBLIC
    -fPIE
)
target_include_directories(${PROJECT_NAME} PUBLIC
    src/cocos
    ${KRKR2CORE_PATH}/environ/cocos2d
    ${PORTBUILD_PATH}/include
    ${PORTBUILD_PATH}/include/breakpad
    ${COCOS2DX_PATH}/cocos
    ${COCOS2DX_PATH}/cocos/audio/include
)
target_link_directories(${PROJECT_NAME} PUBLIC
    ${PORTBUILD_PATH}/lib
)
target_link_libraries(${PROJECT_NAME} PUBLIC
    -Wl,-Bstatic
    krkr2core krkr2plugin
)