
#!/bin/bash
LOCAL_FOLDER=$(basename "`pwd`")
mkdir ./Images

rsync -P -az "sherlock:/home/users/nbachand/Cascade/city_block_cfd/CHARLES/config2/$LOCAL_FOLDER/plots" ./
rsync -P -az "sherlock:/home/users/nbachand/Cascade/city_block_cfd/CHARLES/config2/$LOCAL_FOLDER/tables" ./
rsync -P -az "sherlock:/scratch/users/nbachand/Cascade/city_block_cfd/CHARLES/config2/$LOCAL_FOLDER/Videos" ./

# rsync -P -z "sherlock:/scratch/users/nbachand/Cascade/city_block_cfd/CHARLES/config2/$LOCAL_FOLDER/Images/u_y5*" ./Images/
