from enum import Enum


class ResponseCode(Enum):
    APPROVED = "00"
    ERROR = "01"
    INV_ACQUIRER = "05"
    ACQ_BAD_USER = "06"


class HealthCheckResponse:
    def __init__(self, response_code, health_check_id):
        self._response_code = response_code
        self._health_check_id = health_check_id

    def json(self):
        return {"ResponseCode": self._response_code, "HealthCheckId": self._health_check_id}


class EventNotificationResponse:
    def __init__(self, response_code, notification_event_id):
        self._response_code = response_code
        self._notification_event_id = notification_event_id

    def json(self):
        return {"ResponseCode": self._response_code, "NotificationEventId": self._notification_event_id}
