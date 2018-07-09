#!/bin/sh
ls $1/*.c | grep -v main.c > files
echo $1/main.c >> files
cat files | xargs cat > $1.c
rm files