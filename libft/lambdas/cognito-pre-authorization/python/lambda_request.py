import appconfig_manager
import jsonpickle
from mask_logging import logger
import os

from aws_xray_sdk.core import patch_all

logger = logger.get_logger()
patch_all()

parameter_name = "/banking-app/%s/shared/mobile/versions/supported"
def lambda_handler(event, context):
    logger.info('## EVENT:')
    logger.info(event)
    logger.info('## CONTEXT:')
    logger.info(context)

    config = appconfig_manager.get_version_configurations(parameter_name % os.environ["ENV_TYPE"])

    logger.info('config:' + config)
    config = jsonpickle.decode(config)
    if not check_caller_and_version(event, config):
        raise Exception("Outdated version of application")
    return event


def check_caller_and_version(event, config):
    called_from = event["callerContext"]["awsSdkVersion"]
    if "ios" not in called_from and "android" not in called_from:
        return True

    if "ios" in event["request"]["validationData"] and event["request"]["validationData"]["ios"] \
            >= config["ios-minimal-version"]:
        return True
    if ("android" in event["request"]["validationData"] and event["request"]["validationData"]["android"]
            >= config["android-minimal-version"]):
        return True
    return False
