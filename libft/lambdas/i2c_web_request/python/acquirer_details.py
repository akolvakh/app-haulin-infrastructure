import secrets_manager
import jsonpickle

class AcquirerDetails:
    def __init__(self, acquirer_details):
        self.acquirer_userid   = acquirer_details['acquirer_userid']
        self.acquirer_password = acquirer_details['acquirer_password']
        self.acquirer_id       = acquirer_details['acquirer_id']

    def auth(self):
        return (self.acquirer_userid, self.acquirer_password)

    def details(self):
        return {"id": self.acquirer_id, "userId": self.acquirer_userid, "password": self.acquirer_password}

    @staticmethod
    def get_acquirer_details(secret_name):
        secret_string      = secrets_manager.get_secret(secret_name = secret_name)
        secret_string_json = jsonpickle.decode(secret_string)
        return AcquirerDetails(secret_string_json)
