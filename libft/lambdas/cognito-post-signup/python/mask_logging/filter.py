import logging


class MaskingFilter(logging.Filter):

    def __init__(self, patterns):
        super(MaskingFilter, self).__init__()
        self._patterns = patterns

    def filter(self, record):
        if isinstance(record.msg, dict):
            self.req_filter(record.msg)
        return True

    def req_filter(self, record):
        for key, value in record.items():
            if isinstance(value, dict):
                record[key] = self.req_filter(value)
            elif isinstance(value, list):
                record[key] = [self.req_filter(element) for element in value]
            else:
                record[key] = self.sanitize_value((key, value))
        return record

    def sanitize_value(self, d):
        for pattern in self._patterns:
            if pattern == d[0]:
                if isinstance(d[1], str):
                    return '*' * len(d[1])
                else:
                    return '*'
        return d[1]
