from init import logger
import argparse
from utils.datasets import *

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=str, default='../data/datasets/', help='source path')
    parser.add_argument('--results', type=str, default='../data/results/', help='result paht')

    parser.add_argument('--mediatotext',type=bool, default= False, help='do media to text')
    parser.add_argument('--texttmedia',type=bool, default= False, help='do media to text')
    parser.add_argument('--vsim',type=bool, default= False, help='do media to text')
    
    opt = parser.parse_args()
    # print(opt)
    # media to text file
    if opt.mediatotext:
        dataset = LoadImages(opt.source, (100,100))
        dataset.to_text(opt.source)
    
    # scrip danh cho vsim
    if opt.vsim:
        logger.info("call vsim scrip ")
        # check format text file

    # text to media
    if opt.texttmedia:
        text_to_media(opt.source, opt.results)
