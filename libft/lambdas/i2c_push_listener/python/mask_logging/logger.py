import logging.config
import os

import yaml


def get_logger():
    file_path = str(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'app.yaml'))
    with open(file_path, 'r') as the_file:
        config_dict = yaml.safe_load(the_file)

    logging.config.dictConfig(config_dict)
    logger = logging.getLogger()
    return logger
