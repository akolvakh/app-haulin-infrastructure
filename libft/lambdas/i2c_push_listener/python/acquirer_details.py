import jsonpickle

import secrets_manager
from lambda_response import ResponseCode


class AcquirerDetails:
    def __init__(self, acquirer_details):
        self.acquirer_userid = acquirer_details['acquirer_userid']
        self.acquirer_password = acquirer_details['acquirer_password']
        self.acquirer_id = acquirer_details['acquirer_id']

    def details(self):
        return {"id": self.acquirer_id, "userId": self.acquirer_userid, "password": self.acquirer_password}

    def auth(self, request):
        ac_id = request["Header"]["Id"]
        user_id = request["Header"]["UserId"]
        password = request["Header"]["Password"]
        if ac_id != self.acquirer_id:
            return ResponseCode.INV_ACQUIRER.value
        elif user_id != self.acquirer_userid or password != self.acquirer_password:
            return ResponseCode.ACQ_BAD_USER.value
        else:
            return ResponseCode.APPROVED.value

    @staticmethod
    def get_acquirer_details(secret_name):
        secret_string = secrets_manager.get_secret(secret_name=secret_name)
        secret_string_json = jsonpickle.decode(secret_string)
        return AcquirerDetails(secret_string_json)
