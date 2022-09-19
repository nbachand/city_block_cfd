# Function that creates a video out of png files
# ARGUMENTS:
# --directory   Directory in which the pngs can be found
# --namefmt     Format of naming, e.g. if the images look like `pavg_Xslice.00004000.png`, enter `pavg_Xslice`.
# --subsample   Frequency with which to subsample the frames
# --dt          Timestep of simulation
# --output      Name of video file to create
# --mirror      Include to mirror images horizontally

import argparse
import cv2
import os

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--directory', type=str, required=True, help='Directory in which the pngs can be found')
    parser.add_argument('--namefmt', type=str, required=True, help='Format of naming, e.g. if the images look like `pavg_Xslice.00004000.png`, enter `pavg_Xslice.`')
    parser.add_argument('--dt', type=float, required=True, help='Timestep of simulation')
    parser.add_argument('--subsample', type=int, default=1, help='Frequency with which to subsample the frames')
    parser.add_argument('--output', type=str, default='video.avi', help='Name of video file to create')
    parser.add_argument('--mirror', help='Include to mirror images horizontally', action='store_true')
    args = parser.parse_args()

    images = [img for img in os.listdir(args.directory) if img.startswith(args.namefmt) and img.endswith(".png")]
    images.sort()
    frame = cv2.imread(os.path.join(args.directory, images[0]))
    height, width, layers = frame.shape

    video = cv2.VideoWriter(args.output, 0, 1/(args.dt * args.subsample), (width,height))

    for image in images:
        im = cv2.imread(os.path.join(args.directory, image))
        if args.mirror:
            im = cv2.flip(im, 1)
        video.write(im)

    cv2.destroyAllWindows()
    video.release()

if __name__ == "__main__":
    main()