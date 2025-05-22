# modified from /home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/lesCreateMovie
import sys
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/cti')
sys.path.append('/home/groups/gorle/codes/fidelityCharles_2024.1/fidelityCharles_2024.2_CTI/scripts/pythonModules')


import cti_image
import  scrOpts as so
import  scrTools as st


import cv2 as cv
from matplotlib import pyplot as plt
from matplotlib import colormaps
import numpy as np
import glob

#---------------------------------------------------------------------------
# func definitions
#---------------------------------------------------------------------------

def create_cbar(data_min, data_max, cm, nticks, title, cb_image_name, cb_w, cb_h, cbar_orient):

    
    fig, ax = plt.subplots(figsize=(cb_w,cb_h))
    fig.subplots_adjust(bottom=0.3)

    fig.patch.set_facecolor((background_color[0]/255, background_color[1]/255, background_color[2]/255))
    ticks = np.linspace(data_min, data_max, nticks) #.astype(int)
    if data_max - data_min > 1:
        ticks = np.round(ticks).astype(int)
    else:
        ticks = np.round(ticks, decimals=3)
    
    norm = plt.Normalize(vmin=np.min(ticks), vmax=np.max(ticks))
    cbar = plt.colorbar(plt.cm.ScalarMappable(norm=norm, cmap=cm),
                        cax=ax, orientation=cbar_orient)
    cbar.set_label(title, fontsize=fontsize)
    cbar.set_ticks(ticks)
    cbar.ax.tick_params(labelsize=fontsize)

    cbar_path = cb_image_name
    plt.savefig(cbar_path, bbox_inches='tight', pad_inches=0.1)
    plt.close()

    return cbar_path

def cbar_padding(cb_loc, img_h, img_w, cb_images, nvar, cbar_orient):
    
    #cb_h, cb_w, _ = cb_images[0].shape
    cb_h_max = max(array.shape[0] for array in cb_images)
    cb_w_max = max(array.shape[1] for array in cb_images)
    
    padded_cb = []
    if nvar==1:
        cb_h = cb_images[0].shape[0]
        cb_w = cb_images[0].shape[1]
        if cbar_orient=='horizontal':
            p_left = (img_w - cb_w)//2; p_right = img_w - cb_w - p_left
            p_top = 0; p_bottom = 0
        elif cbar_orient=='vertical':
            p_left = 0; p_right = 0
            p_top = (img_h - cb_h)//2; p_bottom = img_h - cb_h - p_top
        p_cb = cv.copyMakeBorder(
            cb_images[0],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        padded_cb.append(p_cb)
        
    elif nvar==2:
        cb_h = cb_images[0].shape[0]
        cb_w = cb_images[0].shape[1] 
        if cbar_orient=='horizontal':
            # left aligned
            p_left = 0; p_right = img_w - cb_w - p_left
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # top aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_top = 0; p_bottom = img_h - cb_h - p_top
        p_cb_1 = cv.copyMakeBorder(
            cb_images[0],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        
        cb_h = cb_images[1].shape[0]
        cb_w = cb_images[1].shape[1] 
        if cbar_orient=='horizontal':
            # right aligned
            p_right = 0; p_left = img_w - cb_w - p_right; 
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # bottom aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_bottom = 0; p_top = img_h - cb_h - p_bottom; 
        p_cb_2 = cv.copyMakeBorder(
            cb_images[1],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )

        p_cb = (p_cb_1 + p_cb_2) 
        p_cb[:,:,0] = p_cb[:,:,0] - background_color[2]
        p_cb[:,:,1] = p_cb[:,:,1] - background_color[1]
        p_cb[:,:,2] = p_cb[:,:,2] - background_color[0]
        padded_cb.append(p_cb)

    elif nvar==3:
        cb_h = cb_images[0].shape[0]
        cb_w = cb_images[0].shape[1] 
        if cbar_orient=='horizontal':
            # left aligned
            p_left = 0; p_right = img_w - cb_w - p_left
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # top aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_top = 0; p_bottom = img_h - cb_h - p_top
        p_cb_1 = cv.copyMakeBorder(
            cb_images[0],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        
        cb_h = cb_images[1].shape[0]
        cb_w = cb_images[1].shape[1] 
        if cbar_orient=='horizontal':
            # right aligned
            p_right = 0; p_left = img_w - cb_w - p_right; 
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # bottom aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_bottom = 0; p_top = img_h - cb_h - p_bottom; 
        p_cb_2 = cv.copyMakeBorder(
            cb_images[1],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )

        p_cb = (p_cb_1 + p_cb_2)
        p_cb[:,:,0] = p_cb[:,:,0] - background_color[2]
        p_cb[:,:,1] = p_cb[:,:,1] - background_color[1]
        p_cb[:,:,2] = p_cb[:,:,2] - background_color[0]
        padded_cb.append(p_cb)

        cb_h = cb_images[2].shape[0]
        cb_w = cb_images[2].shape[1]
        if cbar_orient=='horizontal':
            # left aligned top alone
            p_left = 0; p_right = img_w - cb_w - p_left
            p_top = 0; p_bottom = 0
        elif cbar_orient=='vertical':
            # top aligned right alone
            p_left = 0; p_right = 0
            p_top = 0; p_bottom = img_h - cb_h - p_top

        p_cb_3 = cv.copyMakeBorder(
            cb_images[2],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        padded_cb.append(p_cb_3)

    elif nvar==4:
        cb_h = cb_images[0].shape[0]
        cb_w = cb_images[0].shape[1] 
        if cbar_orient=='horizontal':
            # left aligned
            p_left = 0; p_right = img_w - cb_w - p_left
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # top aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_top = 0; p_bottom = img_h - cb_h - p_top
        p_cb_1 = cv.copyMakeBorder(
            cb_images[0],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        
        cb_h = cb_images[1].shape[0]
        cb_w = cb_images[1].shape[1] 
        if cbar_orient=='horizontal':
            # right aligned
            p_right = 0; p_left = img_w - cb_w - p_right; 
            p_top = 0; p_bottom = cb_h_max - cb_h
        elif cbar_orient=='vertical':
            # bottom aligned
            p_left = 0; p_right = cb_w_max - cb_w
            p_bottom = 0; p_top = img_h - cb_h - p_bottom; 
        p_cb_2 = cv.copyMakeBorder(
            cb_images[1],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )

        p_cb = (p_cb_1 + p_cb_2)
        p_cb[:,:,0] = p_cb[:,:,0] - background_color[2]
        p_cb[:,:,1] = p_cb[:,:,1] - background_color[1]
        p_cb[:,:,2] = p_cb[:,:,2] - background_color[0]
        padded_cb.append(p_cb)

        cb_h = cb_images[2].shape[0]
        cb_w = cb_images[2].shape[1] 
        if cbar_orient=='horizontal':
            # left aligned top 
            p_left = 0; p_right = img_w - cb_w - p_left
            p_top = cb_h_max - cb_h; p_bottom = 0
        elif cbar_orient=='vertical':
            # top aligned 
            p_left = 0; p_right = cb_w_max - cb_w
            p_top = 0; p_bottom = img_h - cb_h - p_top
        p_cb_3 = cv.copyMakeBorder(
            cb_images[2],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )

        cb_h = cb_images[3].shape[0]
        cb_w = cb_images[3].shape[1]
        if cbar_orient=='horizontal':
            # right aligned top 
            p_right = 0; p_left = img_w - cb_w - p_right 
            p_top = cb_h_max - cb_h; p_bottom = 0
        elif cbar_orient=='vertical':
            # bottom aligned 
            p_left = 0; p_right = cb_w_max - cb_w
            p_bottom = 0; p_top = img_h - cb_h - p_bottom
        p_cb_4 = cv.copyMakeBorder(
            cb_images[3],
            top=int(p_top), bottom=int(p_bottom), 
            left=int(p_left), right=int(p_right),
            borderType=cv.BORDER_CONSTANT, value=(background_color[2],background_color[1],background_color[0])
        )
        p_cb = (p_cb_3 + p_cb_4)
        p_cb[:,:,0] = p_cb[:,:,0] - background_color[2]
        p_cb[:,:,1] = p_cb[:,:,1] - background_color[1]
        p_cb[:,:,2] = p_cb[:,:,2] - background_color[0]
        padded_cb.append(p_cb)

    return padded_cb

def process_image(image_path, varlist, cmaplist):

    im = cti_image.Image(image_path)
    im.getImageMetadataAndChunks()
    img = im.getRGB()
    for v, var in enumerate(varlist):
        new_image = img.copy()
        if im.daTa is not None: # and im.flAg is not None:
            color_mapped_img = plt.get_cmap(cmaplist[v])(im.chunks['daTa']/255.0)
        else:
            img_gs = np.mean(new_image, axis=-1) / 255
            var_min = im.metadata[var]['range'][0]
            var_max = im.metadata[var]['range'][1]
            img_gs = img_gs * (var_max - var_min) + var_min # scale up with local range
            img_gs = (img_gs - data_min[v]) / (data_max[v] - data_min[v]) # scale down with global range
            color_mapped_img = plt.get_cmap(colormap)(img_gs)

        color_mapped_img = (color_mapped_img[:,:,:3] * 255).astype(np.uint8)

        if im.flAg is not None:
            mask = im.getMask(var)
        else:
            mask = im.zoNe > 100

        new_image[mask] = color_mapped_img[mask]
        color_mapped_img = cv.cvtColor(new_image.astype(np.uint8), cv.COLOR_RGB2BGR)


    return color_mapped_img


def get_varTypes(image_path):

    varslist = ['planar']
    cmaplist = [colormap_planar]
    cb_names = [prefix + 'colorbar.png']
    titles = [cbar_title]


    im = cti_image.Image(image_path)
    im.getImageMetadataAndChunks()
    data_min = [im.metadata['planar']['range'][0]]
    data_max = [im.metadata['planar']['range'][1]]

    if im.metadata['iso']['available'] == True:
        varslist.append('iso')
        cmaplist.append(colormap_iso)
        cb_names.append(prefix + 'colorbar_iso.png')
        data_min.append(im.metadata['iso']['range'][0])
        data_max.append(im.metadata['iso']['range'][1])
        titles.append(cbar_iso_title)

    if im.metadata['surf']['available'] == True:
        varslist.append('surf')
        cmaplist.append(colormap_surf)
        cb_names.append(prefix + 'colorbar_surf.png')
        data_min.append(im.metadata['surf']['range'][0])
        data_max.append(im.metadata['surf']['range'][1])
        titles.append(cbar_surf_title)

    if im.metadata['particle']['available'] == True:
        varslist.append('particle')
        cmaplist.append(colormap_particle)
        cb_names.append(prefix + 'colorbar_particle.png')
        data_min.append(im.metadata['particle']['range'][0])
        data_max.append(im.metadata['particle']['range'][1])
        titles.append(cbar_particle_title)

    return varslist, cmaplist, cb_names, data_min, data_max, titles
    

if __name__ == "__main__":

    #---------------------------------------------------------------------------
    # Set up the configuration
    #---------------------------------------------------------------------------

    inpOpts = [
        {"varName":"help",
        "shortName":"h","longName":"help","default":False,"type":"boolean",
        "helpString":"list help and exit"},
        {"varName":"infile",
        "shortName":"infile","longName":"infile","default":'',"type":"string",
        "helpString":"input png images, e,g, '/path/to/images/T*png'"},
        {"varName":"prefix",
        "shortName":"prefix","longName":"prefix","default":'./',"type":"string",
        "helpString":"path where outputs will saved."},
        {"varName":"movie_filename",
        "shortName":"movie_filename","longName":"movie_filename","default":'output_video',"type":"string",
        "helpString":"provide the output file name without the extension. it will be .mp4"}, 
        {"varName":"fps",
        "shortName":"fps","longName":"frames_per_second","default":10,"type":"integer",
        "helpString":"choose frames per second"},
        {"varName":"add_cbar_movie",
        "shortName":"add_cbar_movie","longName":"add_cbar_movie","default":True,"type":"boolean",
        "helpString":"Should colorbar be added in the movie?"}, 
        {"varName":"colormap",
        "shortName":"colormap","longName":"colormap_planar","default":'jet',"type":"string",
        "helpString":"choose a colormap"},
        {"varName":"colormap_iso",
        "shortName":"colormap_iso","longName":"colormap_iso","default":'viridis',"type":"string",
        "helpString":"choose a colormap for iso surfaces"},
        {"varName":"colormap_surf",
        "shortName":"colormap_surf","longName":"colormap_surf","default":'coolwarm',"type":"string",
        "helpString":"choose a surface colormap"},
        {"varName":"colormap_particle",
        "shortName":"colormap_particle","longName":"colormap_particle","default":'hot',"type":"string",
        "helpString":"choose a colormap for the particles"},
        {"varName":"cbar_title",
        "shortName":"cbar_title","longName":"colormap_title_planar","default":'planar_data',"type":"string",
        "helpString":"choose a cbar title for planar data"},
        {"varName":"cbar_iso_title",
        "shortName":"cbar_iso_title","longName":"cbar_iso_title","default":'iso_data',"type":"string",
        "helpString":"choose a cbar title for iso data"},
        {"varName":"cbar_surf_title",
        "shortName":"cbar_surf_title","longName":"cbar_surf_title","default":'surface_data',"type":"string",
        "helpString":"choose a cbar title for surface data"},
        {"varName":"cbar_particle_title",
        "shortName":"cbar_particle_title","longName":"cbar_particle_title","default":'particle data',"type":"string",
        "helpString":"choose a cbar title for the particle data"},
        {"varName":"cbar_width_frac",
        "shortName":"cbar_width_frac","longName":"cbar_width_frac","default":0.2,"type":"float",
        "helpString":"choose cbar width fraction comapared to the original image width"},
        {"varName":"cbar_height_frac",
        "shortName":"cbar_height_frac","longName":"cbar_height_frac","default":0.1,"type":"float",
        "helpString":"choose cbar height fraction comapared to the original image height"},
        {"varName":"cbar_orient",
        "shortName":"cbar_orient","longName":"cbar_orientation","default":'horizontal',"type":"string",
        "helpString":"choose colorbar orientation: horizontal or vertical"},
        {"varName":"nticks",
        "shortName":"nticks","longName":"nticks","default":5,"type":"integer",
        "helpString":"choose number of ticks in each colorbar"},
        {"varName":"fontsize",
        "shortName":"fontsize","longName":"fontsize","default":12,"type":"integer",
        "helpString":"choose fontsize for the ticklabels and title in each colorbar"},
    ]

    # Directly specify inpOpts values in the script
    optTable = so.scrOpts(inpOpts)
    image_base = "u_y1p5"
    image_folder = "//scratch/users/nbachand/Cascade/city_block_cfd/CHARLES/config2/R53/Images"
    # image_base = "SIDE"
    # image_folder = "/oak/stanford/groups/gorle/form2flow/CEE261C-local/SUBS/nbachand/Final/submission-02/IMAGES"

    video_folder = "/oak/stanford/groups/gorle/nbachand/Cascade/city_block_cfd/CHARLES/config2/R53/Videos"
    video_base = f"{image_base}_pyVid"

    # Set options directly
    optTable.setOptionVal("infile", f"{image_folder}/{image_base}*.png")
    optTable.setOptionVal("movie_filename", f"{video_folder}/{video_base}")
    optTable.setOptionVal("prefix", "")
    optTable.setOptionVal("fps", 30)
    optTable.setOptionVal("colormap", "plasma")
    optTable.setOptionVal("colormap_iso", "seismic")
    optTable.setOptionVal("cbar_orient", "vertical")
    optTable.setOptionVal("cbar_width_frac", 0.02)
    optTable.setOptionVal("cbar_height_frac", 0.45)
    optTable.setOptionVal("fontsize", 14)

    #---------------------------------------------------------------------------
    # get the configuration values
    #---------------------------------------------------------------------------

    infile         = optTable.getOptionVal(   "infile"               ) ;
    prefix         = optTable.getOptionVal(   "prefix"               ) ;
    movie_filename         = optTable.getOptionVal(   "movie_filename"               ) ;
    fps         = optTable.getOptionVal(   "fps"               ) ;
    add_cbar_movie         = optTable.getOptionVal(   "add_cbar_movie"               ) ;
    colormap         = optTable.getOptionVal(   "colormap"               ) ;
    colormap_iso         = optTable.getOptionVal(   "colormap_iso"               ) ;
    colormap_surf         = optTable.getOptionVal(   "colormap_surf"               ) ;
    colormap_particle         = optTable.getOptionVal(   "colormap_particle"               ) ;
    cbar_title         = optTable.getOptionVal(   "cbar_title"               ) ;
    cbar_iso_title         = optTable.getOptionVal(   "cbar_iso_title"               ) ;
    cbar_surf_title         = optTable.getOptionVal(   "cbar_surf_title"               ) ;
    cbar_particle_title         = optTable.getOptionVal(   "cbar_particle_title"               ) ;
    cbar_width_frac         = optTable.getOptionVal(   "cbar_width_frac"               ) ;
    cbar_height_frac         = optTable.getOptionVal(   "cbar_height_frac"               ) ;
    cbar_orient         = optTable.getOptionVal(   "cbar_orient"               ) ;
    nticks         = optTable.getOptionVal(   "nticks"               ) ;
    fontsize         = optTable.getOptionVal(   "fontsize"               ) ;


    #---------------------------------------------------------------------------
    # Check the parameters
    #---------------------------------------------------------------------------

    if infile=='':
        st.scrErr("No input file given")

    output = prefix + movie_filename + '.mp4'
    colormap_planar = colormap

    all_mpl_cmaps = list(colormaps)
    if colormap_planar not in all_mpl_cmaps:
        st.scrErr("colormap planar: " + colormap_planar + " not available in matplotlib")
    if colormap_iso not in all_mpl_cmaps:
        st.scrErr("colormap iso: " + colormap_iso + " not available in matplotlib")
    if colormap_surf not in all_mpl_cmaps:
        st.scrErr("colormap surf: " + colormap_surf + " not available in matplotlib")
    if colormap_particle not in all_mpl_cmaps:
        st.scrErr("colormap particle: " + colormap_particle + " not available in matplotlib")




    #---------------------------------------------------------------------------
    # print the parameters
    #---------------------------------------------------------------------------

    st.scrPrint('input params:')
    st.scrPrint('  infile  = %s' % infile )
    st.scrPrint('  prefix  = %s' % prefix )
    st.scrPrint('  movie_filename  = %s' % movie_filename )
    st.scrPrint('  fps  = %s' % fps )
    st.scrPrint('  add_cbar_movie  = %s' % add_cbar_movie )
    st.scrPrint('  colormap  = %s' % colormap )
    st.scrPrint('  colormap_iso  = %s' % colormap_iso )
    st.scrPrint('  colormap_surf  = %s' % colormap_surf )
    st.scrPrint('  colormap_particle  = %s' % colormap_particle )
    st.scrPrint('  cbar_title  = %s' % cbar_title )
    st.scrPrint('  cbar_iso_title  = %s' % cbar_iso_title )
    st.scrPrint('  cbar_surf_title  = %s' % cbar_surf_title )
    st.scrPrint('  cbar_particle_title  = %s' % cbar_particle_title )
    st.scrPrint('  cbar_width_frac  = %s' % cbar_width_frac )
    st.scrPrint('  cbar_height_frac  = %s' % cbar_height_frac )
    st.scrPrint('  cbar_orient  = %s' % cbar_orient )
    st.scrPrint('  nticks  = %s' % nticks )
    st.scrPrint('  fontsize  = %s' % fontsize )


    #---------------------------------------------------------------------------
    # load data and do calculations
    #---------------------------------------------------------------------------
    files = sorted(glob.glob(infile))

    dpi = 80
    background_color = [73, 175, 205] # bahama blue rgb

    vars_list, cmaplist, cb_names, data_min, data_max, titles = get_varTypes(files[-1])
    nvar = len(vars_list)
    last_image = process_image(files[-1], vars_list, cmaplist)
    image_width = last_image.shape[1]
    image_height = last_image.shape[0]
    cbar_width = cbar_width_frac*image_width/dpi
    cbar_height = cbar_height_frac*image_height/dpi

    cbar_img = []
    for v, var in enumerate(vars_list):
        cbar_path = create_cbar(data_min[v], data_max[v], cmaplist[v], nticks, titles[v], cb_names[v],
                                        cbar_width, cbar_height, cbar_orient)
        cbar_img.append(cv.imread(cbar_path))

    if add_cbar_movie:
        cb_resized = cbar_padding(None, last_image.shape[0], last_image.shape[1], cbar_img, nvar, cbar_orient)

        if cbar_orient == 'horizontal':
            if len(cb_resized) == 1:
                last_image_combined = np.vstack((last_image, cb_resized[0]))
            elif len(cb_resized) == 2:
                last_image_combined = np.vstack((cb_resized[1], last_image, cb_resized[0]))
        elif cbar_orient == 'vertical':
            if len(cb_resized) == 1:
                last_image_combined = np.hstack((last_image, cb_resized[0]))
            elif len(cb_resized) == 2:
                last_image_combined = np.hstack((cb_resized[1], last_image, cb_resized[0]))

        h, w, _ = last_image_combined.shape
    else:
        h, w, _ = last_image.shape

    fourcc = cv.VideoWriter_fourcc(*'mp4v')  # Codec (e.g., XVID, MJPG, MP4V)  
    frame_size = (w, h)  # (width, height)
    out = cv.VideoWriter(output, fourcc, fps, frame_size)

    for img_path in files:
        print(img_path)
        frame = process_image(img_path, vars_list, cmaplist)

        if add_cbar_movie:
            if cbar_orient == 'horizontal':
                if len(cb_resized) == 1:
                    combined_frame = np.vstack((frame, cb_resized[0]))
                elif len(cb_resized) == 2:
                    combined_frame = np.vstack((cb_resized[1], frame, cb_resized[0]))
            elif cbar_orient == 'vertical':
                if len(cb_resized) == 1:
                    combined_frame = np.hstack((frame, cb_resized[0]))
                elif len(cb_resized) == 2:
                    combined_frame = np.hstack((cb_resized[1], frame, cb_resized[0]))
        else:
            combined_frame = frame

        out.write(combined_frame)

    out.release()