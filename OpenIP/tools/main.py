from init import logger
from utils.datasets import *

if __name__ == "__main__":
    logger.info("hello world")
    # video to text file
    # media_to_text("./data/images","./data/images",(100,100),2)
    # dataset = LoadImages("./data/images", (100,100))
    # dataset.to_text("./data/images/")
    text_to_media("./data/results/","./data/results/")
