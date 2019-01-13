#!/bin/bash

DUR_SECONDS=$(ffprobe -i "$1" -show_entries format=duration -v quiet -of csv="p=0")

CUT_BEFORE=8
#CUT_AFTER=7.5
CUT_AFTER=8


START_TIME=($CUT_BEFORE)

END_TIME=$(bc <<< "$DUR_SECONDS - $CUT_AFTER")


ffmpeg -i "$1" -ss $START_TIME -to $END_TIME -c copy "trimmed-$1"
