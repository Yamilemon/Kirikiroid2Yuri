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