#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
cd "$filepath"

mkdir release
mkdir release/patches
mkdir release/roms

mkdir release/roms/GBC专用汉化版
mkdir release/roms/GB共通汉化版
mkdir release/roms/VC


cp pokegold.gbc release/roms/GBC专用汉化版/pokegold.gbc
cp pokesilver.gbc release/roms/GBC专用汉化版/pokesilver.gbc
cp pokegold_64KB.gbc release/roms/GB共通汉化版/pokegold_64KB.gbc
cp pokesilver_64KB.gbc release/roms/GB共通汉化版/pokesilver_64KB.gbc


cp pokegold.patch release/roms/GBC专用汉化版/pokegold.patch
cp pokesilver.patch release/roms/GBC专用汉化版/pokesilver.patch
cp pokegold.patch release/patches/pokegold.patch
cp pokesilver.patch release/patches/pokesilver.patch

cp pokegold.sym release/roms/GBC专用汉化版/pokegold.sym
cp pokesilver.sym release/roms/GBC专用汉化版/pokesilver.sym
cp pokegold_64KB.sym release/roms/GB共通汉化版/pokegold_64KB.sym
cp pokesilver_64KB.sym release/roms/GB共通汉化版/pokesilver_64KB.sym
cp pokegold.sym release/patches/pokegold.sym
cp pokesilver.sym release/patches/pokesilver.sym
cp pokegold_64KB.sym release/patches/pokegold_64KB.sym
cp pokesilver_64KB.sym release/patches/pokesilver_64KB.sym


flips -c pokegold-o.gbc pokegold.gbc -i release/patches/pokegold.ips
flips -c pokesilver-o.gbc pokesilver.gbc -i release/patches/pokesilver.ips
flips -c pokegold-o.gbc pokegold_64KB.gbc -i release/patches/pokegold_64KB.ips
flips -c pokesilver-o.gbc pokesilver_64KB.gbc -i release/patches/pokesilver_64KB.ips



if [[ "$OSTYPE" == "darwin"* ]]; then
md5 pokegold.gbc > release/patches/patched-md5.txt
md5 pokesilver.gbc >> release/patches/patched-md5.txt
md5 pokegold_64KB.gbc >> release/patches/patched-md5.txt
md5 pokesilver_64KB.gbc >> release/patches/patched-md5.txt

else
md5sum pokegold.gbc > release/patches/patched-md5.txt
md5sum pokesilver.gbc >> release/patches/patched-md5.txt
md5sum pokegold_64KB.gbc >> release/patches/patched-md5.txt
md5sum pokesilver_64KB.gbc >> release/patches/patched-md5.txt
fi

cp VersionUpdate.md release/roms/汉化版版本更新历史.txt
cp VersionUpdate.md release/patches/VersionUpdate.md

cp pokegold.gbc /Users/tom/Library/Containers/com.isaacmarovitz.Whisky/Bottles/DFA10767-07CD-4F1B-9881-30F28A2CB1DF/drive_c/local/DN_3DS/pokegold.gbc
cp pokesilver.gbc /Users/tom/Library/Containers/com.isaacmarovitz.Whisky/Bottles/DFA10767-07CD-4F1B-9881-30F28A2CB1DF/drive_c/local/DN_3DS/pokesilver.gbc
cp pokegold.patch /Users/tom/Library/Containers/com.isaacmarovitz.Whisky/Bottles/DFA10767-07CD-4F1B-9881-30F28A2CB1DF/drive_c/local/DN_3DS/pokegold.patch
cp pokesilver.patch /Users/tom/Library/Containers/com.isaacmarovitz.Whisky/Bottles/DFA10767-07CD-4F1B-9881-30F28A2CB1DF/drive_c/local/DN_3DS/pokesilver.patch