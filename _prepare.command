#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
cd "$filepath"

python3 -c 'import bs4, openpyxl' 2>/dev/null || {
    echo 'Missing Python dependencies: install beautifulsoup4 and openpyxl.' >&2
    exit 1
}

echo Creating build directory...
# rm -r build
mkdir build
cp -r src/* build
cd build

# The copied binary may be older than its updated RGBDS 1.0.4-compatible source.
make -B -C tools make_patch || exit 1

# echo 正在备份文件...
# mkdir tmp
mkdir __Hash
# python3 tools/_backup.py xlsx/xlsxList.txt xlsx/ 0 2

chmod +x ./_importBuild.sh
if xattr -p com.apple.quarantine ./_importBuild.sh >/dev/null 2>&1; then
    xattr -d com.apple.quarantine ./_importBuild.sh
fi
./_importBuild.sh || exit $?
