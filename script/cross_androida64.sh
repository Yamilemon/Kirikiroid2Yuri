# bash -c "export SKIP_PORTS=yes && ./cross_androida64.sh"
PLATFORM=androida64
BUILD_PATH=./../build_${PLATFORM}
CMAKELISTS_PATH=$(pwd)/..
PORTBUILD_PATH=$CMAKELISTS_PATH/thirdparty/build/arch_$PLATFORM
ANDROID_THIRDPARTY_PATH=$CMAKELISTS_PATH/src/onsyuri_android/app/cpp/thirdparty
CORE_NUM=$(cat /proc/cpuinfo | grep -c ^processor)
TARGETS=$@

function fetch_ports()
{
    fetch_vorbis
    fetch_ogg
    fetch_opus
    fetch_opusfile
    fetch_unrar
    fetch_sdl2

    fetch_archive
    fetch_breakpad
    fetch_ffmpeg
    fetch_jpeg
    fetch_syscall
    fetch_lz4
    fetch_oniguruma
    fetch_openal
    fetch_opencv
    fetch_oboe
    fetch_bpg
    fetch_jxr
}

function build_ports()
{
    # build_opus
    # build_libogg
    # build_libvorbis
    # build_opusfile
    # build_unrar
    # build_breakpad
    # build_jpegturbo
    build_ffmpeg
}

# prepare env, tested with ndk 25.2.9519653
if [ -n $ANDROID_HOME ]; then ANDROID_HOME=/d/Software/env/sdk/androidsdk; fi
NDK_HOME=$ANDROID_HOME/ndk/$(ls -A $ANDROID_HOME/ndk | tail -n 1)
PREBUILT_DIR=$NDK_HOME/toolchains/llvm/prebuilt
PREBUILT_DIR=$PREBUILT_DIR/$(ls -A $PREBUILT_DIR | tail -n 1)
PATH=$PREBUILT_DIR/bin:$PATH
CC=$(which aarch64-linux-android21-clang)
CXX=$(which aarch64-linux-android21-clang++)
AR=$(which llvm-ar)
RANLIB=$(which llvm-ranlib)
NM=$(which llvm-nm)
STRIP=$(which llvm-strip)
SYSROOT=$PREBUILT_DIR/sysroot

# SKIP_PORTS="yes"
echo "## ANDROID_HOME=$ANDROID_HOME"
echo "## CC=$CC, AR=$AR"
if [ -z "$SKIP_PORTS" ]; then
    source ./_fetch.sh
    source ./_$PLATFORM.sh
    fetch_ports
    build_ports
fi

exit

# config and build project
if [ -z "$BUILD_TYPE" ]; then BUILD_TYPE=MinSizeRel; fi
if [ -z "$TARGETS" ]; then TARGETS=assembleRelease; fi

pushd ${CMAKELISTS_PATH}/src/onsyuri_android
echo "ANDROID_HOME=$ANDROID_HOME" 
chmod +x ./gradlew && ./gradlew $TARGETS --no-daemon
popd