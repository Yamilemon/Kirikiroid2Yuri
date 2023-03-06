cmake_minimum_required(VERSION 3.6)
project(krkr2core)

# search kr2core src
set(KRKR2CORE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
file(GLOB KRKR2CORE_CODE 
    ${KRKR2CORE_PATH}/visual/*.cpp
    ${KRKR2CORE_PATH}/base/*.cpp
    ${KRKR2CORE_PATH}/base/win32/*.cpp
    ${KRKR2CORE_PATH}/environ/*.cpp
    ${KRKR2CORE_PATH}/environ/ConfigManager/*.cpp
    ${KRKR2CORE_PATH}/environ/cocos2d/*.cpp
    ${KRKR2CORE_PATH}/environ/android/*.cpp
    ${KRKR2CORE_PATH}/environ/linux/*.cpp
    ${KRKR2CORE_PATH}/environ/ui/*.cpp
    ${KRKR2CORE_PATH}/environ/ui/extension/*.cpp
    ${KRKR2CORE_PATH}/environ/win32/SystemControl.cpp 
    ${KRKR2CORE_PATH}/extension/*.cpp
    ${KRKR2CORE_PATH}/movie/*.cpp
    ${KRKR2CORE_PATH}/movie/*/*.cpp
    ${KRKR2CORE_PATH}/msg/*.cpp
    ${KRKR2CORE_PATH}/msg/win32/MsgImpl.cpp
    ${KRKR2CORE_PATH}/msg/win32/OptionsDesc.cpp 
    ${KRKR2CORE_PATH}/sound/*.cpp
    ${KRKR2CORE_PATH}/sound/win32/*.cpp
    ${KRKR2CORE_PATH}/tjs2/*.cpp
    ${KRKR2CORE_PATH}/utils/*.c
    ${KRKR2CORE_PATH}/utils/*.cpp
    ${KRKR2CORE_PATH}/utils/encoding/*.c
    ${KRKR2CORE_PATH}/utils/minizip/*.c
    ${KRKR2CORE_PATH}/utils/minizip/*.cpp
    ${KRKR2CORE_PATH}/utils/win32/*.cpp
    ${KRKR2CORE_PATH}/visual/gl/*.cpp
    ${KRKR2CORE_PATH}/visual/ogl/*.cpp
    ${KRKR2CORE_PATH}/visual/win32/*.cpp
    ${KRKR2CORE_PATH}/visual/ARM/*.cpp
    ${KRKR2CORE_PATH}/visual/ARM/*.c
)
list(REMOVE_ITEM KRKR2CORE_CODE
    ${KRKR2CORE_PATH}/visual/Resampler.cpp
    ${KRKR2CORE_PATH}/base/win32/FuncStubs.cpp
    ${KRKR2CORE_PATH}/base/win32/SusieArchive.cpp
    ${KRKR2CORE_PATH}/environ/MainFormUnit.cpp
    ${KRKR2CORE_PATH}/sound/xmmlib.cpp
    ${KRKR2CORE_PATH}/sound/WaveFormatConverter_SSE.cpp
    ${KRKR2CORE_PATH}/visual/win32/GDIFontRasterizer.cpp 
    ${KRKR2CORE_PATH}/visual/win32/NativeFreeTypeFace.cpp
    ${KRKR2CORE_PATH}/visual/win32/TVPSysFont.cpp 
    ${KRKR2CORE_PATH}/visual/win32/VSyncTimingThread.cpp
    ${KRKR2CORE_PATH}/visual/LoadJXR.cpp
    ${KRKR2CORE_PATH}/visual/LoadBPG.cpp
)

# make krkr2core
add_library(${PROJECT_NAME} STATIC ${KRKR2CORE_CODE})
target_include_directories(${PROJECT_NAME} PUBLIC     
    ${KRKR2CORE_PATH}/
    ${KRKR2CORE_PATH}/base
    ${KRKR2CORE_PATH}/base/win32 
    ${KRKR2CORE_PATH}/environ 
    ${KRKR2CORE_PATH}/environ/win32 
    ${KRKR2CORE_PATH}/environ/android 
    ${KRKR2CORE_PATH}/environ/sdl 
    ${KRKR2CORE_PATH}/msg 
    ${KRKR2CORE_PATH}/msg/win32 
    ${KRKR2CORE_PATH}/extension
    ${KRKR2CORE_PATH}/sound 
    ${KRKR2CORE_PATH}/sound/win32 
    ${KRKR2CORE_PATH}/tjs2
    ${KRKR2CORE_PATH}/utils 
    ${KRKR2CORE_PATH}/utils/win32
    ${KRKR2CORE_PATH}/visual
    ${KRKR2CORE_PATH}/visual/ARM
    ${KRKR2CORE_PATH}/visual/win32
    ${KRKR2CORE_PATH}/visual/RenderScript/rs
    ${KRKR2CORE_PATH}/../plugins
    ${KRKR2CORE_PATH}/../../thirdparty/port/cocos2d-x/cocos
    ${CMAKE_SYSROOT}/include
    ${CMAKE_SYSROOT}/sdk/native/jni
)
target_compile_definitions(${PROJECT_NAME} PUBLIC
    -DTJS_TEXT_OUT_CRLF -D__STDC_CONSTANT_MACROS -DUSE_UNICODE_FSTRING
    -DTJS_TEXT_OUT_CRLF -D_7ZIP_ST
)
target_link_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_SYSROOT}/lib
)
target_link_libraries(${PROJECT_NAME} PUBLIC
    -Wl,-Bstatic
    cocos2d
    ext_freetype

    unrar
    lz4
    7za
    archive #  libbpg_static jxrlib_static
    
    SDL2
    turbojpep
    opencv_core
    opencv_imgproc
    ffmpeg
    openal
    onig
    ogg
    opus
    vorbis 
    vorbisfile 
    vorbisenc 
    opusfile 
    breakpad
    breakpad_client
    -Wl,-Bdynamic
)