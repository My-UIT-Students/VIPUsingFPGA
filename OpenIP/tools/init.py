import logging
import logging.config

logging.config.fileConfig('logging.conf')
# create logger
logger = logging.getLogger('VIP-APP')
