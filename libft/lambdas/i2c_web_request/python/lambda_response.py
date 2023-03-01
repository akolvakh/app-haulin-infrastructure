class ErrorResponse:
    def __init__(self, status_code, reason):
        self._status_code = status_code
        self._reason      = reason

    def json(self):
        return { "status_code": self._status_code, "reason": self._reason }

class JsonResponse:
    def __init__(self, status_code, reason, json):
        self._status_code = status_code
        self._reason      = reason
        self._json        = json
    
    def json(self):
        return { "status_code": self._status_code, "reason": self._reason, "json": self._json }