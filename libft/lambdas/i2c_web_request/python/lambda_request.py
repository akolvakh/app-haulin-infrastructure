import jsonpickle
import requests
import cachetools.func

from aws_xray_sdk.core import patch_all
from urllib3.util.retry import Retry
from requests.adapters import HTTPAdapter
from requests.exceptions import RetryError

from acquirer_details import AcquirerDetails
from lambda_env import LambdaEnv
from lambda_response import ErrorResponse, JsonResponse
from mask_logging import logger

logger = logger.get_logger()
patch_all()

class Request:
    def __init__(self):
        key = "request_url"
        self._request_url = LambdaEnv([key]).value(key)

    @cachetools.func.ttl_cache(maxsize=16, ttl=20)
    def _get_session(self):
        session = requests.Session()
        # maximum time for retry is 0.5s+1.5s+3.5s+7.5s (backoff delays) + 5*3s (requests timeout) = 28s
        retries = Retry(
            total=5,  # Total number of retries to allow
            backoff_factor=0.5,  # A backoff factor to apply between attempts
            status_forcelist=[429, 500, 502, 503, 504],  # A set of HTTP status codes that we should force a retry on
            allowed_methods=['POST']  # By default all methods are allowed except POST, so we explicitly allow POST
        )
        session.mount('https://', HTTPAdapter(max_retries=retries))  # for all https requests library will do 5 retries
        return session

    def _get_headers(self):
        return {'Content-type': 'application/json'}
    
    def _get_url(self, api):
        #return 'https://wdc-ws2.mycardplace.com:6443/MCPWebServicesRestful/services/MCPWSHandler/%s' % api
        return 'https://%s:6443/MCPWebServicesRestful/services/MCPWSHandler/%s' % (self._request_url, api)
    
    def _api_payload(self, acquirer_details, api, event): 
        # If acquirer exists it is overwritten.
        event[api]["acquirer"] = acquirer_details
        return jsonpickle.encode(event)

    def _api_request(self, event, api_name, acquirer):
        url = self._get_url(api_name)
        logger.info('Request URL: ' + url)
        payload = self._api_payload(acquirer.details(), api_name, event)  # do not log payload, it now has creds
        headers = self._get_headers()
        return self._get_session().post(url, data=payload, auth=acquirer.auth(), headers=headers, timeout=3)

    def __call__(self, event, context, acquirer):
        keys    = [*event]

        if(len(keys) == 0):
            reason = 'Invalid Request Json - no api key specified'
            logger.error(reason)
            return ErrorResponse(status_code = requests.status_codes.codes['BAD_REQUEST'], reason = reason)
    
        if(len(keys) > 1):
            # Show up to 5 keys 
            reason = 'Invalid Request Json - only one api key allowed: ' + str(keys[:min(5, len(keys))])
            logger.error(reason)
            return ErrorResponse(status_code = requests.status_codes.codes['BAD_REQUEST'], reason = reason)
        
        api_name = keys[0]  # confirmed only 1 above
        try:
            result = self._api_request(event, api_name, acquirer)
        except RetryError as retry_error:
            logger.info("Max retries exceeded: %s" % retry_error)
            return JsonResponse(status_code = 503, reason = 'Max retries exceeded', json = "{}")

        if(result.status_code == requests.status_codes.codes['OK']):
            return JsonResponse(status_code = result.status_code, 
                                reason = result.reason,
                                json = result.json())
        
        # Request Failed - Log Reason, Code, Header, and attempt to return result.json().
        logger.info("Reason:  " + result.reason)
        logger.info("Code:    " + str(result.status_code))
        logger.info("Headers: " + repr(result.headers))
        try:
            return JsonResponse(status_code = result.status_code, reason = result.reason, json = result.json())
        except:
            return JsonResponse(status_code = result.status_code, reason = result.reason, json = "{}")

def get_caller_id(base = "i2c_api_", key = "environment"):
    lenv = LambdaEnv([key])
    return base + lenv.value(key)


def lambda_handler(event, context):
    logger.info('## EVENT:')
    logger.info(event)
    logger.info('## CONTEXT:')
    logger.info(context)
    caller_id = get_caller_id()
    logger.info("Caller ID:" + caller_id)
    acquirer = AcquirerDetails.get_acquirer_details(caller_id)
    result = dict(Request()(event, context, acquirer).json())
    logger.info("Status Code: " + str(result["status_code"]))
    logger.info(result)
    return result
