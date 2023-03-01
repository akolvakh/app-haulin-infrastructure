import copy
import logging


class CustomHandler(logging.StreamHandler):
    def handle(self, record):
        copy_record = copy.deepcopy(record)
        rv = self.filter(copy_record)
        if rv:
            self.acquire()
            try:
                self.emit(copy_record)
            finally:
                self.release()
        return rv
