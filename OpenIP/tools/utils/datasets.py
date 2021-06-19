import glob
import logging
import math
import os
import random
import shutil
import time
from itertools import repeat
from multiprocessing.pool import ThreadPool
from pathlib import Path
from threading import Thread
import cv2
import numpy as np

img_formats = ['bmp', 'jpg', 'jpeg', 'png', 'tif', 'tiff', 'dng']  # acceptable image suffixes
vid_formats = ['mov', 'avi', 'mp4', 'mpg', 'mpeg', 'm4v', 'wmv', 'mkv', 'ts']  # acceptable video suffixes
text_formats = ['txt']
logger = logging.getLogger(__name__)


def text_to_media(src_path, dest_path):
    p = str(Path(src_path))  # os-agnostic
    p = os.path.abspath(p)  # absolute path
    if '*' in p:
        files = sorted(glob.glob(p, recursive=True))  # glob
    elif os.path.isdir(p):
        files = sorted(glob.glob(os.path.join(p, '*.*')))  # dir
    elif os.path.isfile(p):
        files = [p]  # files
    else:
        raise Exception('ERROR: %s does not exist' % p)

    files = [x for x in files if x.split('.')[-1].lower() in text_formats]
    for file in files:
        try:
            with open(file, "r") as f:
                logger.info("#file:{}".format(file))
                type = int(f.readline().strip())
                width = int(f.readline().strip())
                height = int(f.readline().strip())
                numframe = int(f.readline().strip())
                if type == 0:
                    # video
                    file_name = dest_path + file.split("/")[-1] + ".avi"
                    out = cv2.VideoWriter(file_name,cv2.VideoWriter_fourcc('M','J','P','G'), 10, (100,100))
                    frame = np.zeros([width, height, 3], dtype=np.uint8)
                    for i in range (0,numframe):
                        for y in range(0, height):
                            for x in range(0, width):
                                frame[x, y, 0] = int(f.readline().strip())
                                frame[x, y, 1] = int(f.readline().strip())
                                frame[x, y, 2] = int(f.readline().strip())
                        print(i)
                        out.write(frame)
                    out.release()
                    print("done")
                if type == 1:
                    # images
                    file_name = dest_path + file.split("/")[-1] + ".jpg"
                    frame = np.zeros([width, height, 3])
                    for y in range(0, height):
                        for x in range(0, width):
                            frame[x, y, 0] = int(f.readline().strip())
                            frame[x, y, 1] = int(f.readline().strip())
                            frame[x, y, 2] = int(f.readline().strip())
                    cv2.imwrite(file_name, frame)

                f.close()
        except BaseException as ex:
            logger.error(ex)


class LoadImages:  # for inference
    def __init__(self, path, img_size=(640, 640), video_frame_step=5, max_frames=5):
        p = str(Path(path))  # os-agnostic
        p = os.path.abspath(p)  # absolute path
        if '*' in p:
            files = sorted(glob.glob(p, recursive=True))  # glob
        elif os.path.isdir(p):
            files = sorted(glob.glob(os.path.join(p, '*.*')))  # dir
        elif os.path.isfile(p):
            files = [p]  # files
        else:
            raise Exception('ERROR: %s does not exist' % p)

        images = [x for x in files if x.split('.')[-1].lower() in img_formats]
        videos = [x for x in files if x.split('.')[-1].lower() in vid_formats]
        ni, nv = len(images), len(videos)
        self.video_frame_step = video_frame_step
        self.img_size = img_size
        self.files = images + videos
        self.nf = ni + nv  # number of files
        self.video_flag = [False] * ni + [True] * nv
        self.mode = 'image'
        self.max_frames = max_frames
        if any(videos):
            self.new_video(videos[0])  # new video
        else:
            self.cap = None
        assert self.nf > 0, 'No images or videos found in %s. Supported formats are:\nimages: %s\nvideos: %s' % \
                            (p, img_formats, vid_formats)

    def __iter__(self):
        self.count = 0
        return self

    def to_text(self, path):
        for file, video_flag in zip(self.files, self.video_flag):
            logger.info("#open-file:{}".format(file))
            dest_file = path +  'text/' + file.split("/")[-1] + '.txt'
            try:
                with open(dest_file, "w") as f:
                    logger.debug("open {}".format(dest_file))
                    cap = cv2.VideoCapture(file)
                    # nframes = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
                    width = self.img_size[0]
                    height = self.img_size[0]
                    if video_flag:
                        # write header
                        f.writelines(["0\n{}\n{}\n{}\n".format(width, height, self.max_frames-1)])
                        # read frame
                        frame_cnt = 0;
                        frame_write = 0;
                        while True:
                            ret, frame = cap.read()
                            if ret:
                                frame_cnt += 1
                                if frame_cnt % self.video_frame_step == 0:
                                    frame_write = frame_write + 1
                                    if frame_write <= self.max_frames:
                                        self.write_pixel(frame, f)
                                    else:
                                        break
                            else:
                                break

                        cap.release()
                        logger.debug("Video  {}".format(file, video_flag))
                    else:
                        f.writelines(["1\n{}\n{}\n1\n".format(width, height)])
                        logger.debug("Images: {}".format(file))
                        frame = cv2.imread(file)
                        self.write_pixel(frame, f)

                    f.close()
                    logger.info("File {} is saved".format(dest_file))
            except BaseException as ex:
                logger.error(ex)

    def write_pixel(self, frame, f):
        width = self.img_size[0]
        height = self.img_size[0]
        im_resize = cv2.resize(frame, self.img_size, interpolation=cv2.INTER_LINEAR)
        for y in range(0, height):
            for x in range(0, width):
                f.writelines("{}\n{}\n{}\n".format(im_resize[x, y, 0],
                                                   im_resize[x, y, 1],
                                                   im_resize[x, y, 2]))

    def __next__(self):
        if self.count == self.nf:
            raise StopIteration
        path = self.files[self.count]

        if self.video_flag[self.count]:
            # Read video
            self.mode = 'video'
            ret_val, img0 = self.cap.read()
            if not ret_val:
                self.count += 1
                self.cap.release()
                if self.count == self.nf:  # last video
                    raise StopIteration
                else:
                    path = self.files[self.count]
                    self.new_video(path)
                    ret_val, img0 = self.cap.read()

            self.frame += 1
            print('video %g/%g (%g/%g) %s: ' % (self.count + 1, self.nf, self.frame, self.nframes, path), end='')

        else:
            # Read image
            self.count += 1
            img0 = cv2.imread(path)  # BGR
            assert img0 is not None, 'Image Not Found ' + path
            print('image %g/%g %s: ' % (self.count, self.nf, path), end='')

        # Padded resize
        # img = letterbox(img0, new_shape=self.img_size)[0]

        # Convert
        img = cv2.resize(img0, (100, 100), interpolation=cv2.INTER_LINEAR)
        return path, img, img0, self.cap,

    def new_video(self, path):
        self.frame = 0
        self.cap = cv2.VideoCapture(path)
        self.nframes = int(self.cap.get(cv2.CAP_PROP_FRAME_COUNT))

    def __len__(self):
        return self.nf  # number of files
