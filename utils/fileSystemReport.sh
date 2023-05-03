#!/bin/bash

FOLDERS_TOTAL=$(find $1 -mindepth 1 -type d | wc -l) 
FILES_TOTAL=$(find $1 -type f | wc -l)
CONF=$(find $1 -type f -name "*.conf" | wc -l)
TXT=$(find $1 -type f -name "*.txt" | wc -l)
EXE=$(find $1 -type f -executable | wc -l)
LOG=$(find $1 -type f -name "*.log" | wc -l)
ARCH=$(find $1 -type f -name "*.a" -o -name "*.ar" -o -name "*.cpio" -o -name "*.shar" -o -name "*.tar" \
 -o -name "*.iso" -o -name "*.mar" -o -name "*.sbx" -o -name "*.bz2" -o -name "*.gz" -o -name "*.lz" \
 -o -name "*.rz" -o -name "*.sfark" -o -name "*.sz" -o -name "*.xz" -o -name "*.z" -o -name "*.Z" \
 -o -name "*.7z" -o -name "*.s7z" -o -name "*.ace" -o -name "*.afa" -o -name "*.alz" -o -name "*.cpt" \
 -o -name "*.apk" -o -name "*.b1" -o -name "*.b6z" -o -name "*.ba" -o -name "*.cab" -o -name "*.cfs" \
 -o -name "*.dar" -o -name "*.dmg" -o -name "*.ear" -o -name "*.genozip" -o -name "*.jar" -o -name "*.kgb" \
 -o -name "*.lzh" -o -name "*.lha" -o -name "*.partimg" -o -name "*.paq" -o -name "*.pea" -o -name "*.phar" \
 -o -name "*.rar" -o -name "*.rk" -o -name "*.sen" -o -name "*.shk" -o -name "*.sit" -o -name "*.war" \
 -o -name "*.xar" -o -name "*.yz1" -o -name "*.zip" | wc -l)
SYMB=$(find $1 -type l | wc -l)

. ./utils/topLib.sh

echo "Total number of folders (including all nested ones) = $FOLDERS_TOTAL"

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
TOP_DIR=($(du $1 | sort -nr | head -n 6 | tail -n 5))
top 5 0 ${TOP_DIR[*]}

echo "Total number of files = $FILES_TOTAL"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONF"
echo "Text files = $TXT"
echo "Executable files = $EXE"
echo "Log files (with the extension .log) = $LOG"
echo "Archive files = $ARCH"  
echo "Symbolic links = $SYMB"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
TOP_FILES=($(find $1 -type f -exec du {} \; | sort -nr | head -n 10))
top 10 1 ${TOP_FILES[*]}

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
TOP_EXE=($(find $1 -type f -executable -exec du {} \; | sort -nr | head -n 10))
top 10 2 ${TOP_EXE[*]}
