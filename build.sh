#!/bin/bash
# by fuldaros
set -e
stamp=$(date +"%Y%m%d-%H%M");
kernel=paperplane_"$stamp";
logb=logb_"$stamp";
otazip=ota_pp_"$stamp";
export ARCH=arm64
export TARGET_ARCH=arm64
export KBUILD_BUILD_USER=fuldaros
export KBUILD_BUILD_HOST=hhost
pwd > pwd.dat
read pwd < pwd.dat
rm -f pwd.dat
export CROSS_COMPILE="$pwd"/tools/bin/aarch64-linux-gnu-
cd sources/
echo "#### made by fuldaros ####"
echo "Подождите...ядро собирается :3"
make -j3 O=../out/paperplane Image.gz-dtb > ../outkernel/"$logb"
echo "Копирую ядро..."
cat ../out/paperplane/arch/arm64/boot/Image.gz-dtb > ../outkernel/"$kernel"
rm -rf ../out/paperplane/arch/arm64/boot/
cd ../
echo "Собираю zip пакет..."
rm -f anykernel2/zImage
cat outkernel/"$kernel" > anykernel2/zImage
zip -r outzip/"$otazip".zip anykernel2/*
echo "OTA Pack created! Name: "$otazip""
echo Success!
