# must use after _fetch.sh from cross_androida64.sh

build_opus() 
{
    if ! [ -d $OPUS_SRC/build_$PLATFORM ]; then mkdir -p $OPUS_SRC/build_$PLATFORM ;fi
    pushd $OPUS_SRC/build_$PLATFORM
    ../configure --host=aarch64-linux-android \
        CC=aarch64-linux-android21-clang  AR=llvm-ar \
        CXX=aarch64-linux-android21-clang++ \
        --prefix=$PORTBUILD_PATH
    make -j$CORE_NUM &&  make install
    popd
}

build_libogg() 
{
    if ! [ -d $OGG_SRC/build_$PLATFORM ]; then mkdir -p $OGG_SRC/build_$PLATFORM ;fi
    pushd $OGG_SRC/build_$PLATFORM
    ../configure --host=aarch64-linux-android \
        CC=aarch64-linux-android21-clang  AR=llvm-ar \
        CXX=aarch64-linux-android21-clang++ \
        --prefix=$PORTBUILD_PATH
    make -j$CORE_NUM &&  make install
    popd
}

build_libvorbis() 
{
    if ! [ -d $VORBIS_SRC/build_$PLATFORM ]; then mkdir -p $VORBIS_SRC/build_$PLATFORM ;fi
    pushd $VORBIS_SRC/build_$PLATFORM
    ../configure --host=aarch64-linux-android \
        CC=aarch64-linux-android21-clang  AR=llvm-ar \
        CXX=aarch64-linux-android21-clang++ \
        --prefix=$PORTBUILD_PATH \
        --with-ogg=$PORTBUILD_PATH
    make -j$CORE_NUM &&  make install
    popd
}

build_opusfile() # after ogg, opus, vorbits
{
    if ! [ -d $OPUS_SRC/build_$PLATFORM ]; then mkdir -p $OPUS_SRC/build_$PLATFORM ;fi
    pushd $OPUS_SRC/build_$PLATFORM
    ../configure --host=aarch64-linux-android \
        CC=aarch64-linux-android21-clang  AR=llvm-ar \
        CXX=aarch64-linux-android21-clang++ \
        --prefix=$PORTBUILD_PATH \
        DEPS_CFLAGS="-I$PORTBUILD_PATH/include" \
        DEPS_LIBS="-L$PORTBUILD_PATH/lib -logg -lopus" \
        --disable-http --disable-examples
    make -j$CORE_NUM &&  make install
    popd
}

build_unrar() 
{   
    cp $CMAKELISTS_PATH/thirdparty/patch/android_ulinks.cpp $UNRAR_SRC/ulinks.cpp
    pushd $UNRAR_SRC
    make clean
    make lib -j$CORE_NUM \
        CXX=aarch64-linux-android21-clang++ \
        AR=llvm-ar STRIP=llvm-strip \
        DESTDIR=$PORTBUILD_PATH  
    mv *.a $PORTBUILD_PATH/lib
    popd
}

build_breakpad() 
{
    if ! [ -d $BREAKPAD_SRC/build_$PLATFORM ]; then mkdir -p $BREAKPAD_SRC/build_$PLATFORM ;fi
    cp -r $SYSCALL_SRC/lss $BREAKPAD_SRC/src/third_party/
    pushd $BREAKPAD_SRC/build_$PLATFORM
    ../configure --host=aarch64-linux-android \
        CC=aarch64-linux-android21-clang  AR=llvm-ar \
        CXX=aarch64-linux-android21-clang++ \
        --prefix=$PORTBUILD_PATH \
        --disable-tools
    make -j$CORE_NUM &&  make install
    popd
}

build_jpegturbo() 
{
    if ! [ -d $JPEG_SRC/build_$PLATFORM ]; then mkdir -p $JPEG_SRC/build_$PLATFORM ;fi
    pushd $JPEG_SRC/build_$PLATFORM
    NDK_PATH=$NDK_HOME
    TOOLCHAIN=clang
    ANDROID_VERSION=21
    cmake .. -G "Unix Makefiles" \
        -DANDROID_ABI=arm64-v8a \
        -DANDROID_ARM_MODE=arm \
        -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
        -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
        -DCMAKE_ASM_FLAGS="--target=aarch64-linux-android${ANDROID_VERSION}" \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH
    make -j$CORE_NUM &&  make install
    popd
}

build_ffmpeg() 
{
    if ! [ -d $FFMPEG_SRC/build_$PLATFORM ]; then mkdir -p $FFMPEG_SRC/build_$PLATFORM ;fi
    pushd $FFMPEG_SRC
    git apply  $CMAKELISTS_PATH/thirdparty/patch/android_ffmpeg.diff
    cd build_$PLATFORM
    ../configure --enable-cross-compile --cross-prefix=aarch64-linux-android- \
        --cc=aarch64-linux-android21-clang  --ar=llvm-ar \
        --cxx=aarch64-linux-android21-clang++ --ranlib=llvm-ranlib \
        --strip=llvm-strip --prefix=$PORTBUILD_PATH \
        --arch=aarch64 --target-os=android --enable-pic \
        --enable-static --enable-shared --enable-small \
        --disable-ffmpeg --disable-ffplay --disable-ffprobe \
        --disable-avdevice --disable-programs --disable-doc

    # use sh directory is not available in windows (absolute path), must use msys2 shell
    make -j$CORE_NUM &&  make install
    popd
}


build_lz4()
{
    pushd $LZ4_SRC
    make clean
    make lib -j$CORE_NUM \
        CC=aarch64-linux-android21-clang \
        CXX=aarch64-linux-android21-clang++ \
        AR=llvm-ar STRIP=llvm-strip \
        WINBASED=no
    mv lib/*.a $PORTBUILD_PATH/lib
    popd
}

build_archive()
{
    if ! [ -d $ARCHIVE_SRC/build_$PLATFORM ]; then mkdir -p $ARCHIVE_SRC/build_$PLATFORM ;fi
    cp $CMAKELISTS_PATH/thirdparty/patch/android_android_lf.h  $ARCHIVE_SRC/libarchive/android_lf.h
    pushd $ARCHIVE_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DENABLE_OPENSSL=OFF -DENABLE_TEST=OFF \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH
    make -j$CORE_NUM &&  make install
    popd
}

build_opencv()
{
    if ! [ -d $OPENCV_SRC/build_$PLATFORM ]; then mkdir -p $OPENCV_SRC/build_$PLATFORM ;fi
    pushd $OPENCV_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH \
        -DWITH_CUDA=OFF -DWITH_MATLAB=OFF -DBUILD_ANDROID_EXAMPLES=OFF \
        -DBUILD_DOCS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF \
        -DBUILD_opencv_video=OFF -DBUILD_opencv_videoio=OFF -DBUILD_opencv_features2d=OFF \
        -DBUILD_opencv_flann=OFF -DBUILD_opencv_highgui=OFF -DBUILD_opencv_ml=OFF \
        -DBUILD_opencv_dnn=OFF -DBUILD_opencv_gapi=OFF -DBUILD_opencv_hal=ON \
        -DBUILD_opencv_photo=OFF -DBUILD_opencv_python=OFF -DBUILD_opencv_shape=OFF \
        -DBUILD_opencv_stitching=OFF -DBUILD_opencv_superres=OFF \
        -DBUILD_opencv_ts=OFF -DBUILD_opencv_videostab=OFF -DBUILD_ANDROID_PROJECTS=OFF
    make -j$CORE_NUM &&  make install # sdk/staticlibs/arm64-v8a
    popd
}

build_openal()
{
    if ! [ -d $OPENAL_SRC/build_$PLATFORM ]; then mkdir -p $OPENAL_SRC/build_$PLATFORM ;fi
    pushd $OPENAL_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH 
    make -j$CORE_NUM &&  make install 
    popd
}

build_oniguruma()
{
    if ! [ -d $ONIGURUMA_SRC/build_$PLATFORM ]; then mkdir -p $ONIGURUMA_SRC/build_$PLATFORM ;fi
    pushd $ONIGURUMA_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH 
    make -j$CORE_NUM &&  make install 
    popd
}

build_sdl2()
{
    if ! [ -d $SDL2_SRC/build_$PLATFORM ]; then mkdir -p $SDL2_SRC/build_$PLATFORM ;fi
    cp $CMAKELISTS_PATH/thirdparty/patch/android_SDL_android.c  $SDL2_SRC/src/core/android/SDL_android.c
    pushd $SDL2_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DANDROID=ON -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH \
        -DHIDAPI=OFF -DHAVE_GCC_WDECLARATION_AFTER_STATEMENT=OFF
    make -j$CORE_NUM &&  make install 
    popd
}

build_cocos2dx()
{
    if ! [ -d $COCOS2DX_SRC/platform/build_$PLATFORM ]; then mkdir -p $COCOS2DX_SRC/build_$PLATFORM ;fi
    git apply  $CMAKELISTS_PATH/thirdparty/patch/android_cocos2dx.diff
    pushd $COCOS2DX_SRC/build_$PLATFORM
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_TOOLCHAIN_FILE=$NDK_HOME/build/cmake/android.toolchain.cmake \
        -DANDROID_PLATFORM=21 -DANDROID_ABI=arm64-v8a \
        -DCMAKE_INSTALL_PREFIX=$PORTBUILD_PATH
    # make -j$CORE_NUM &&  make install 
    popd
}