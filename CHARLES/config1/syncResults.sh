
#!/bin/bash
LOCAL_FOLDER=$(basename "`pwd`")
mkdir ./Images

rsync -P -r "sherlock:/home/users/nbachand/Cascade/city_block_cfd/CHARLES/config1/$LOCAL_FOLDER/plots" ./
rsync -P -r "sherlock:/home/users/nbachand/Cascade/city_block_cfd/CHARLES/config1/$LOCAL_FOLDER/tables" ./
rsync -P "sherlock:/scratch/users/nbachand/Cascade/city_block_cfd/CHARLES/config1/$LOCAL_FOLDER/Images/u_y5*" ./Images/
