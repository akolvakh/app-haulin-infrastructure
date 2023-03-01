import os

import requests
from aws_xray_sdk.core import patch_all

from lambda_response import ErrorResponse, JsonResponse
from mask_logging import logger

logger = logger.get_logger()
patch_all()


class Request:
    def _get_headers(self):
        return {'Content-type': 'application/json'}

    def _get_url(self, api):
        return 'https://' + os.environ["API_DNS_NAME"] + '/%s' % api

    def _has_early_access_flag(self, request):
        if not "clientMetadata" in request:
            return False

        cm = request["clientMetadata"]
        if ('earlyAccess' in cm) and (cm['earlyAccess'] == 'true'):
            return True

        return False

    def _is_not_prod(self):
        return os.environ["ENV_TYPE"] != 'prod'

    def _is_not_zytara_email_user(self, email):
        domain_name = email.split('@')[1]
        return domain_name != 'zytara.com'

    def _is_early_access_allowed(self, response):
        return ('addedToWaitList' in response) and not response['addedToWaitList']

    def __call__(self, event, context):
        # catch empty json
        keys = [*event]
        if len(keys) == 0 or not 'request' in event:
            reason = "invalid request json - no 'request' details"
            logger.error(reason)
            raise Exception(ErrorResponse(status_code=requests.status_codes.codes['BAD_REQUEST'], reason=reason).json())

        request = event['request']

        url = self._get_url('early-access/')
        payload = request["userAttributes"]["email"]

        if self._is_not_prod() and self._is_not_zytara_email_user(payload):
            reason = "invalid request json - domain name is not 'zytara.com'"
            logger.error(reason)
            raise Exception(
                ErrorResponse(status_code=requests.status_codes.codes['BAD_REQUEST'], reason=reason).json())

        headers = self._get_headers()
        logger.info("Invoking URL: " + url)
        result = requests.post(url, data=payload, headers=headers)
        logger.info("Result is : " + str(result))
        logger.info("Code: " + str(result.status_code))
        logger.info("Reason: " + result.reason)
        logger.info("Headers: " + repr(result.headers))
        logger.info("Response: " + str(result.json()))
        # These exceptions are translated in the front-end to control flow of early access.  An exception must be returned,
        # to allow these strings to propagate back through the cognito API.  Cognito doesn't distinguish between different types of
        # 200 return types.  Passing the return value as an exception alloed us to parse the result.  One thing to have considered
        # here was whether we could have used other return codes.  Given they are not known http values, that probably would not have
        # worked either.
        try:
            if not self._has_early_access_flag(request) and self._is_early_access_allowed(result.json()):
                logger.info("Early access flow was not requested by the front-end")
                return event

            response = JsonResponse(status_code=result.status_code, reason=result.reason, json=result.json()).json()
        except:
            response = JsonResponse(status_code=result.status_code, reason=result.reason, json="{}").json()
        logger.info('Lambda response: ' + str(response))
        raise Exception(response)


def lambda_handler(event, context):
    # NO LOGIC OR ERROR HANDLING IN MAIN - USE THE CLASS
    logger.info('## EVENT:')
    logger.info(event)
    logger.info('## CONTEXT:')
    logger.info(context)
    result = Request()(event, context)
    return result
