import logging
import unittest

import filter

logger = logging.getLogger()
masking_filter = filter.MaskingFilter(['phone_number', 'birthdate'])

test_email = "test@gmail.com"


class TestFunction(unittest.TestCase):
    def test_log_masking(self):
        input_json = {
            "userAttributes": {
                "email": test_email,
                "phone_number": "123-321-123",
                "birthdate": "01.01.1990",
                "userName": "user123"
            }
        }

        with self.assertLogs() as log_content:
            logger.info(input_json)
            record = log_content.records[0]
            masking_filter.filter(record)
            self.assertIn('\'email\': \'test@gmail.com\'', str(record))
            self.assertIn('\'phone_number\': \'***********\'', str(record))
            self.assertIn('\'userName\': \'user123\'', str(record))
            self.assertIn('\'birthdate\': \'**********\'', str(record))

    def test_log_masking_with_list(self):
        input_json = {
            "userAttributes": {
                "some_list": [
                    {"email": test_email},
                    {"phone_number": "123-321-123"}
                ]
            }
        }

        with self.assertLogs() as log_content:
            logger.info(input_json)
            record = log_content.records[0]
            masking_filter.filter(record)
            self.assertIn('\'email\': \'test@gmail.com\'', str(record))
            self.assertIn('\'phone_number\': \'***********\'', str(record))

    def test_log_masking_with_numbers(self):
        input_json = {
            "userAttributes": {
                "email": test_email,
                "phone_number": 123

            }
        }

        with self.assertLogs() as log_content:
            logger.info(input_json)
            record = log_content.records[0]
            masking_filter.filter(record)
            self.assertIn('\'email\': \'test@gmail.com\'', str(record))
            self.assertIn('\'phone_number\': \'*\'', str(record))


if __name__ == '__main__':
    unittest.main()
