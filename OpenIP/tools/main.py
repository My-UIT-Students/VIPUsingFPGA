from init import logger
import argparse
from utils.datasets import *

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=str, default='../data/datasets/', help='source path')
    parser.add_argument('--results', type=str, default='../data/results/', help='result paht')
    opt = parser.parse_args()
    print(opt)
    # video to text file
    dataset = LoadImages(opt.source, (100,100))
    dataset.to_text(opt.source)
    text_to_media(opt.source, opt.results)
