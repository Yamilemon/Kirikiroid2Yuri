cmake_minimum_required(VERSION 3.6)
project(krkr2core)

set(KRKR2CORE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(COCOS2DX_PATH ${KRKR2CORE_PATH}/../../thirdparty/port/cocos2d-x)

# search kr2core src
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
)

file(GLOB KRKR2CORE_CODEARM
    ${KRKR2CORE_PATH}/sound/ARM/*.c
    ${KRKR2CORE_PATH}/sound/ARM/*.cpp
    ${KRKR2CORE_PATH}/visual/ARM/*.cpp
    ${KRKR2CORE_PATH}/visual/ARM/*.c
)

list(REMOVE_ITEM KRKR2CORE_CODE
    ${KRKR2CORE_PATH}/base/win32/FuncStubs.cpp
    ${KRKR2CORE_PATH}/base/win32/SusieArchive.cpp
    ${KRKR2CORE_PATH}/environ/MainFormUnit.cpp
    ${KRKR2CORE_PATH}/environ/XP3ArchiveRepack.cpp
    ${KRKR2CORE_PATH}/environ/ui/XP3RepackForm.cpp
    ${KRKR2CORE_PATH}/sound/xmmlib.cpp
    ${KRKR2CORE_PATH}/sound/WaveFormatConverter_SSE.cpp
    ${KRKR2CORE_PATH}/visual/Resampler.cpp
    ${KRKR2CORE_PATH}/visual/win32/GDIFontRasterizer.cpp 
    ${KRKR2CORE_PATH}/visual/win32/NativeFreeTypeFace.cpp
    ${KRKR2CORE_PATH}/visual/win32/TVPSysFont.cpp 
    ${KRKR2CORE_PATH}/visual/win32/VSyncTimingThread.cpp
    ${KRKR2CORE_PATH}/visual/LoadJXR.cpp
    ${KRKR2CORE_PATH}/visual/LoadBPG.cpp
)

if(CMAKE_SYSTEM_NAME MATCHES "Android")
    list(APPEND KRKR2CORE_CODE ${KRKR2CORE_CODEARM})
    set(PLATFORM android)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(PLATFORM linux)
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    set(PLATFORM win32)
else()
    set(PLATFORM android)
endif()

# make krkr2core
add_library(${PROJECT_NAME} STATIC ${KRKR2CORE_CODE})
if(CMAKE_SYSTEM_NAME MATCHES "Android")
    target_include_directories(${PROJECT_NAME} PUBLIC
        ${PORTBUILD_PATH}/sdk/native/jni/include
        ${CMAKE_ANDROID_NDK}/sources/android/cpufeatures
    )
    target_link_libraries(${PROJECT_NAME} PUBLIC
        -Wl,-Bdynamic
        log
        android
        EGL
        GLESv2
        GLESv1_CM
        GLESv3
        OpenSLES
    )
endif()
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

    ${COCOS2DX_PATH}
    ${COCOS2DX_PATH}/cocos
    ${COCOS2DX_PATH}/cocos/scripting
    ${COCOS2DX_PATH}/cocos/editor-support
    ${COCOS2DX_PATH}/extensions
    ${COCOS2DX_PATH}/external
    ${COCOS2DX_PATH}/external/png/include/${PLATFORM}
    ${COCOS2DX_PATH}/external/webp/include/${PLATFORM}
    ${COCOS2DX_PATH}/external/freetype2/include/${PLATFORM}
    ${COCOS2DX_PATH}/external/freetype2/include/${PLATFORM}/freetype2

    ${PORTBUILD_PATH}/include
)

target_compile_definitions(${PROJECT_NAME} PUBLIC
    -DTJS_TEXT_OUT_CRLF -D__STDC_CONSTANT_MACROS -DUSE_UNICODE_FSTRING
    -DTJS_TEXT_OUT_CRLF -D_7ZIP_ST 
)
target_compile_options(${PROJECT_NAME} PUBLIC 
    -fPIC
)

target_link_directories(${PROJECT_NAME} PUBLIC
    ${PORTBUILD_PATH}/lib
)
target_link_libraries(${PROJECT_NAME} PUBLIC
    -Wl,-Bstatic
    # audio
    ogg
    opus
    vorbis 
    vorbisfile 
    vorbisenc 
    opusfile
    oboe
    openal

    # image
    jpeg
    turbojpeg
    opencv_imgproc
    opencv_core
    tegra_hal
    
    # video
    avutil
    avfilter
    avformat
    avcodec
    swscale
    swresample

    # archive
    unrar
    lz4
    archive #  libbpg_static jxrlib_static
    7za

    # others
    onig
    breakpad
    breakpad_client
    
    # framework
    SDL2
    cocos2d
    ext_unzip
    ext_tinyxml2
    ext_xxhash
    ext_edtaa3func
    ext_poly2tri
    ext_recast
    ext_clipper
    ext_convertUTF
    ext_pvmp3dec
    cpp_android_spec
    chipmunk
    BulletCollision
    BulletDynamics
    BulletMultiThreaded
    LinearMath
    MiniCL

    z
    png
    webp
    libtiff
    freetype
    
    -Wl,-Bdynamic
)