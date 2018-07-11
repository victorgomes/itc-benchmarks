#!/bin/sh

mkdir -p separated/w_Defects;
mkdir -p separated/wo_Defects;
rm -rf _gen/;
mkdir _gen/;

for f in 01.w_Defects/*.c; do
  echo "Gen (w_Defects) $f";
  cp $f _gen/`basename $f`;
  sed "s/FILLME/`basename $f .c`/" MAIN_TEMPLATE >> _gen/`basename $f`;
  mv _gen/`basename $f` separated/w_Defects/`basename $f`
done;

for f in 02.wo_Defects/*.c; do
  echo "Gen (wo_Defects) $f";
  cp $f _gen/`basename $f`;
  sed "s/FILLME/`basename $f .c`/" MAIN_TEMPLATE >> _gen/`basename $f`;
  mv _gen/`basename $f` separated/wo_Defects/`basename $f`
done;

cp 01.w_Defects/HeaderFile.h separated/w_Defects;
cp 02.wo_Defects/HeaderFile.h separated/wo_Defects;
echo "Done!"
