#%% 
import sys
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/cti')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/pythonModules')


import cti_image
from lesCreateMovie import process_image

from matplotlib import pyplot as plt
import cv2 as cv
import numpy as np

#%%

varslist = ['planar']
cmaplist = ['plasma']

data_min = [0]
data_max = [2]

image_path = "/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES/config3/temp_images/R16_mean_u_y1p5.00240000.png"

image = process_image(image_path, varslist, cmaplist)
image = cv.cvtColor(image.astype(np.uint8), cv.COLOR_BGR2RGB)

plt.imshow(image)
# plt.imshow(image, cmap=cmaplist[0], vmin=data_min[0], vmax=data_max[0])
plt.colorbar()
plt.show()
# %%
