
#!/bin/bash
LOCAL_FOLDER=$(basename "`pwd`")
mkdir ./Images

sherlockOakSync plots
sherlockOakSync tables
sherlockOakSync Videos

mkdir Images
cd Images
sherlockScratchSync images_recolored
