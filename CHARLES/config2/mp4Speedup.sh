!#/bin/bash
cd ./Videos
for i in *.mp4; do ffmpeg -i "$i" -filter:v "setpts=PTS/$1" "respeed_$i"; done
