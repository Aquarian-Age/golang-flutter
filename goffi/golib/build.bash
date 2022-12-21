#!/bin/bash

# https://juejin.cn/post/7059276884667793415

export ANDROID_NDK_HOME=/home/user/Android/Sdk/ndk-bundle

export GOARCH=arm
export GOOS=android
export CGO_ENABLED=1
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi30-clang
garble -literals  build -ldflags "-w -s" -trimpath -buildmode=c-shared -o ./bin/armeabi-v7a/libgo.so ./main.go
echo Build armeabi-v7a finish

export GOARCH=arm64
export GOOS=android
export CGO_ENABLED=1
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang
garble -literals  build -ldflags "-w -s" -trimpath -buildmode=c-shared -o ./bin/arm64-v8a/libgo.so ./main.go
echo Build arm64-v8a finish

export GOARCH=amd64
export GOOS=android
export CGO_ENABLED=1
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android30-clang
garble -literals  build -ldflags "-w -s" -trimpath -buildmode=c-shared -o ./bin/x86_64/libgo.so ./main.go
echo Build x86_64 finish


export GOARCH=386
export GOOS=android
export CGO_ENABLED=1
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android30-clang
garble -literals build -ldflags "-w -s" -trimpath -buildmode=c-shared -o ./bin/x86/libgo.so ./main.go
echo Build x86 finish
 