# Krikiroid2-Yuri

A krikiroid2 project matained by Yurisizuku.  
Support the newer android device and more format.  
Windows or linux will also be supported (in future).

New features :  

- develop  
  - [x] clear camke project structure
  - [x] well documention for develop and usage
  - [x] scripts to compile or cross compile without pain
  - [x] vscode and android studio project for multi enviroment
  - [ ] ci in github action to automaticly build
- platform
  - android
    - [x] SDK level above 21 (android 5.1, Lolipop)
    - [ ] SAF to access extern sdcard
  - windows
  - linux
- render  
- game support

## 1. usage

## 2. Build  

I add some futures by reverse engine before, and now this project can be build from source.  In windows, you must use msys2 to build ffmpeg port.  

prepare:

- wget, git, make, cmake, msys2 (if windows)  
- android sdk with `ANDROID_HOME` variable in env  
- ndk 25.2.9519653  

## 3. Compatibility  

|game|version|status|description|
|----|-------|------|-----------|

## 4. Issues (including solved)

## 5. Todo

___
Original information about kirikiroid2 bellow, also refered the dependencies from [ningshanwutuobang](https://github.com/ningshanwutuobang/Kirikiroid2).  

## Kirikiroid2 - A cross-platform port of Kirikiri2/KirikiriZ  

==========================================================

Based on most code from [Kirikiri2](http://kikyou.info/tvp/) and [KirikiriZ](https://github.com/krkrz/krkrz)

Video playback module modified from [kodi](https://github.com/xbmc/xbmc)

Some string code from [glibc](https://www.gnu.org/s/libc) and [Apple Libc](https://opensource.apple.com/source/Libc).

Real-time texture codec modified from [etcpak](https://bitbucket.org/wolfpld/etcpak.git), [pvrtccompressor](https://bitbucket.org/jthlim/pvrtccompressor), [astcrt](https://github.com/daoo/astcrt)

Android storage accessing code from [AmazeFileManager](https://github.com/arpitkh96/AmazeFileManager)
