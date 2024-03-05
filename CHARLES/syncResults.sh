
#!/bin/bash
LOCAL_FOLDER=$(basename "`pwd`")
mkdir ./Images

sherlockOakSync plots
sherlockOakSync tables
sherlockOakSync Videos

sherlockScratchSync Images/images_recolored
