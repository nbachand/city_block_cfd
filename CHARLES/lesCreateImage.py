#%% 
import sys
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/cti')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/pythonModules')

import cti_image
from lesCreateMovie import (
    process_image, create_cbar, cbar_padding,
    setup_options, set_default_options, get_options, validate_parameters
)

from matplotlib import pyplot as plt
import cv2 as cv
import numpy as np
import os

#%%
# Define global variables needed by lesCreateMovie functions
# Define parameters (no need for globals now)
background_color = [73, 175, 205]  # bahama blue rgb
fontsize = 14

# Define path to image and parameters
image_path = "/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES/config3/temp_images/R16_mean_u_y1p5.00240000.png"
output_dir = "/Users/nicholasbachand/Documents/Research/Cascade/city_block_cfd/CHARLES/output_images"
os.makedirs(output_dir, exist_ok=True)

# Define variable parameters
varslist = ['planar']
cmaplist = ['plasma']
data_min = [0]
data_max = [2]
cbar_title = "Velocity (m/s)"

# Process the image using the function from lesCreateMovie
image = process_image(image_path, varslist, cmaplist, data_min, data_max)
image_rgb = cv.cvtColor(image.astype(np.uint8), cv.COLOR_BGR2RGB)

#%% Method 1: Standard matplotlib display (as previously done)
plt.figure(figsize=(10, 8))
plt.imshow(image_rgb)
plt.colorbar(label=cbar_title)
plt.title("Standard Matplotlib Display")
plt.savefig(os.path.join(output_dir, "matplotlib_display.png"), bbox_inches='tight')
plt.show()

#%% Method 2: Using lesCreateMovie's colorbar functions
# Set up parameters for colorbar creation
dpi = 80
cbar_width_frac = 0.05  # Width of colorbar relative to image
cbar_height_frac = 0.8  # Height of colorbar relative to image
cbar_orient = "vertical"  # "horizontal" or "vertical"
nticks = 5

# Calculate dimensions
image_width = image.shape[1]
image_height = image.shape[0]
cbar_width = cbar_width_frac * image_width / dpi
cbar_height = cbar_height_frac * image_height / dpi

# Create colorbar using lesCreateMovie function - now passing background_color and fontsize
cbar_path = os.path.join(output_dir, "colorbar.png")
create_cbar(data_min[0], data_max[0], cmaplist[0], nticks, cbar_title, 
           cbar_path, cbar_width, cbar_height, cbar_orient, 
           background_color, fontsize)

# Load the colorbar and use cbar_padding to create proper layout - now passing background_color
cbar_img = [cv.imread(cbar_path)]
cb_resized = cbar_padding(None, image.shape[0], image.shape[1], 
                         cbar_img, 1, cbar_orient, background_color)

# Combine image and colorbar
if cbar_orient == 'horizontal':
    combined_image = np.vstack((image, cb_resized[0]))
else:  # vertical
    combined_image = np.hstack((image, cb_resized[0]))

# Save the combined image
output_path = os.path.join(output_dir, "image_with_colorbar.png")
cv.imwrite(output_path, combined_image)
print(f"Saved image with colorbar to {output_path}")

# Display the combined image
combined_image_rgb = cv.cvtColor(combined_image, cv.COLOR_BGR2RGB)
plt.figure(figsize=(12, 10))
plt.imshow(combined_image_rgb)
plt.axis('off')
plt.title("Image with Custom Colorbar from lesCreateMovie")
plt.savefig(os.path.join(output_dir, "display_with_custom_colorbar.png"), bbox_inches='tight')
plt.show()

#%% Method 3: Reusable function leveraging lesCreateMovie components
def create_image_with_colorbar(
    image_path, output_path, 
    varlist=['planar'], cmaplist=['plasma'],
    data_min=[0], data_max=[1], 
    cbar_title="Data", cbar_orient="vertical",
    cbar_width_frac=0.05, cbar_height_frac=0.8,
    nticks=5, fontsize=14,
    background_color=[73, 175, 205]  # bahama blue rgb
):
    """Create and save an image with a properly formatted colorbar
    
    Args:
        image_path: Path to input image
        output_path: Path to save the resulting image
        varlist: List of variable types to process
        cmaplist: List of colormaps to use
        data_min: List of minimum values for colormaps
        data_max: List of maximum values for colormaps
        cbar_title: Title for the colorbar
        cbar_orient: Orientation of colorbar ("horizontal" or "vertical")
        cbar_width_frac: Width of colorbar as fraction of image width
        cbar_height_frac: Height of colorbar as fraction of image height
        nticks: Number of ticks on colorbar
        fontsize: Font size for colorbar text
        background_color: RGB color for background (default: bahama blue)
    
    Returns:
        Combined image with colorbar
    """
    # No need for context manager or global variables anymore
    
    # Process the image
    image = process_image(image_path, varlist, cmaplist, data_min, data_max)
    
    # Calculate dimensions
    dpi = 80
    image_width = image.shape[1]
    image_height = image.shape[0]
    cbar_width = cbar_width_frac * image_width / dpi
    cbar_height = cbar_height_frac * image_height / dpi
    
    # Create temporary colorbar file
    temp_cbar_path = "temp_colorbar.png"
    
    # Create colorbar - passing parameters explicitly
    create_cbar(data_min[0], data_max[0], cmaplist[0], nticks, cbar_title, 
               temp_cbar_path, cbar_width, cbar_height, cbar_orient,
               background_color, fontsize)
    
    # Load and process colorbar - passing parameters explicitly
    cbar_img = [cv.imread(temp_cbar_path)]
    cb_resized = cbar_padding(None, image.shape[0], image.shape[1], 
                             cbar_img, 1, cbar_orient, background_color)
    
    # Combine image and colorbar
    if cbar_orient == 'horizontal':
        combined_image = np.vstack((image, cb_resized[0]))
    else:  # vertical
        combined_image = np.hstack((image, cb_resized[0]))
    
    # Save the combined image
    cv.imwrite(output_path, combined_image)
    print(f"Saved image with colorbar to {output_path}")
    
    # Clean up temporary file
    if os.path.exists(temp_cbar_path):
        os.remove(temp_cbar_path)
    
    return combined_image

# Example usage of the reusable function
custom_output = os.path.join(output_dir, "custom_function_output.png")
result = create_image_with_colorbar(
    image_path, custom_output,
    data_min=[0], data_max=[2], 
    cbar_title="Velocity (m/s)",
    cbar_orient="vertical"
)

# Display the result
plt.figure(figsize=(12, 10))
plt.imshow(cv.cvtColor(result, cv.COLOR_BGR2RGB))
plt.axis('off')
plt.title("Result from Reusable Function")
plt.show()
# %%
