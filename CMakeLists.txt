cmake_minimum_required(VERSION 3.6)
set(APP_NAME kirikiroid2)
project(${APP_NAME})

function(config_linux TARGET_NAME)
    add_executable(${TARGET_NAME} ${ONSYURI_CODE})
    message("Linux enviroment for ${TARGET_NAME}, type ${CMAKE_BUILD_TYPE}, compiler ${CMAKE_C_COMPILER}")
endfunction()

function(config_windows TARGET_NAME)
    add_executable(${TARGET_NAME} WIN32 
        ${ONSYURI_CODE}
        ${PROJECT_SOURCE_DIR}/asset/icon1.rc)
    if(MINGW)
    else()
        message("Windows enviroment for ${TARGET_NAME} not supported!")
    endif()
endfunction()

function(config_android TARGET_NAME)
    add_library(${TARGET_NAME} SHARED ${ONSYURI_CODE})
    message("Android enviroment for ${TARGET_NAME}, type ${CMAKE_BUILD_TYPE}, compiler ${CMAKE_C_COMPILER}")
endfunction()

function(config_platform TARGET_NAME)
    if(CMAKE_SYSTEM_NAME MATCHES "Linux")
        config_linux(${TARGET_NAME})
    elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
        config_windows(${TARGET_NAME}) 
    elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
        config_android(${TARGET_NAME})
    else()
        message("${CMAKE_SYSTEM_NAME} enviroment for ${TARGET_NAME} not supported!")
    endif()
endfunction()

set(CMAKE_CXX_STANDARD 11)
config_platform(${PROJECT_NAME})