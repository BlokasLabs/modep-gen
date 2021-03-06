#!/bin/bash -e

DATA_DIR=/tmp/mod-lv2-data

git clone --depth 1 https://github.com/BlokasLabs/mod-lv2-data ${DATA_DIR}

for i in `comm -12 <(ls ${DATA_DIR}/plugins-fixed | grep -v bad) <(ls ${LV2_ABS_DIR})`; do
	if test -e ${LV2_ABS_DIR}/$i/modgui; then
		echo Skipping copying lv2 data over $i as it already contains modgui.
	else
		echo Copying $i data...;
		cp -r ${DATA_DIR}/plugins-fixed/$i ${LV2_ABS_DIR}/
	fi
done

for i in `comm -12 <(ls ${DATA_DIR}/plugins | grep -v bad) <(ls ${LV2_ABS_DIR})`; do
	if test -e ${LV2_ABS_DIR}/$i/modgui; then
		echo Skipping copying lv2 data over $i as it already contains modgui.
	else
		if test -e ${DATA_DIR}/plugins/$i/modgui; then
			echo Copying $i data...;
			cp -r ${DATA_DIR}/plugins/$i ${LV2_ABS_DIR}/
		else
			echo Skipping $i with no modgui folder...
		fi
	fi
done

ls -1 ${LV2_ABS_DIR}/
ls -1 ${LV2_ABS_DIR}/ | wc -l

rm -rf ${DATA_DIR}

