#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
cd "$filepath"



python3 tools/_importTextData.py xlsx/data.xlsx 2 GS $option
python3 tools/_importDexText.py xlsx/dexText.xlsx xlsx/dex.xlsx
python3 tools/_importDexData.py xlsx/dex.xlsx

python3 tools/text_import_sys.py GS
python3 tools/text_import_text.py GS
 


# FOR quickest single version build, chhose fone
# make gold_64
# make silver_debug --always-make

# FOR Non Debug Only
# make gold_64 silver_64 --always-make

# FOR VC Patch
# make gold_vc silver_vc --always-make

# FOR debug only
# make gold_debug_32 silver_debug_32 --always-make

# FOR debug release
# make gold_64 silver_64 gold_debug_32 silver_debug_32 --always-make

# FOR everything
make

# FOR ROM & VC Final release
# make gold_64 silver_64 gold_vc silver_vc --always-make

# echo Restore Backup?
# echo 1.Yes
# echo 2.No
# read restoreOption
# if [ -z "${restoreOption}" ]
# then
#     echo The Option is not set, using the default one.
#     restoreOption=1
# fi

NOW=$( date '+%F_%H:%M:%S' )
python3 tools/_exportJSON.py __Hash/_Gen2-$NOW.json
cp __Hash/_Gen2-$NOW.json Gen2.json
cp __Hash/_Gen2-$NOW.json ../src/Gen2.json

# if [[ $restoreOption -eq 2 ]]
# then
# echo done!
# else
# python3 tools/_backup.py xlsx/xlsxList.txt xlsx/ 1 2
# echo done!
# fi

if [[ "$OSTYPE" == "darwin"* ]]; then
md5 pokegold.gbc > __Hash/_md5-$NOW.txt
md5 pokesilver.gbc >> __Hash/_md5-$NOW.txt
md5 pokegold_debug.gbc >> __Hash/_md5-$NOW.txt
md5 pokesilver_debug.gbc >> __Hash/_md5-$NOW.txt
md5 pokegold_64KB.gbc >> __Hash/_md5-$NOW.txt
md5 pokesilver_64KB.gbc >> __Hash/_md5-$NOW.txt
md5 pokegold_vc.gbc >> __Hash/_md5-$NOW.txt
md5 pokesilver_vc.gbc >> __Hash/_md5-$NOW.txt

else
md5sum pokegold.gbc > __Hash/_md5-$NOW.txt
md5sum pokesilver.gbc >> __Hash/_md5-$NOW.txt
md5sum pokegold_debug.gbc >> __Hash/_md5-$NOW.txt
md5sum pokesilver_debug.gbc >> __Hash/_md5-$NOW.txt
md5sum pokegold_64KB.gbc >> __Hash/_md5-$NOW.txt
md5sum pokesilver_64KB.gbc >> __Hash/_md5-$NOW.txt
md5sum pokegold_vc.gbc >> __Hash/_md5-$NOW.txt
md5sum pokesilver_vc.gbc >> __Hash/_md5-$NOW.txt
fi

cp __Hash/_md5-$NOW.txt md5.txt
cp __Hash/_md5-$NOW.txt ../src/md5.txt

echo done!