
#!/bin/bash
LOCAL_FOLDER=$(basename "`pwd`")
mkdir ./Images

sherlockHomeSync plots
sherlockHomeSync tables
sherlockScratchSync Videos

# sherlockScratchSync Images
