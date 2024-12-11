#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
cd "$filepath"

echo 正在备份文件...
mkdir tmp
mkdir __Hash
python3 tools/_backup.py xlsx/xlsxList.txt xlsx/ 0 2

chmod +x ./_importBuild.command
xattr -d com.apple.quarantine ./_importBuild.sh
./_importBuild.sh

