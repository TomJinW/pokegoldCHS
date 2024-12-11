#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
cd "$filepath"

# python3 -m install beautifulsoup4

echo 正在备份文件...
mkdir tmp
mkdir __Hash
python3 tools/_backup.py xlsx/xlsxList.txt xlsx/ 0 2

patch -p1 < tcc_winport.diff
chmod +x ./_importBuild.sh
./_importBuild.sh