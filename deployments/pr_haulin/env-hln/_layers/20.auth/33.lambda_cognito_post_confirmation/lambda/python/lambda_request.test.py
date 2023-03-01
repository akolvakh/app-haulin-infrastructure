import json
import unittest
from unittest.mock import patch

import lambda_function

CONFIRMED_EVENT = "event/user_email_confirmed_event.json"


class SignupConfirmTest(unittest.TestCase):

    @patch('lambda_function.add_user_to_group')
    @patch('lambda_function.send_message')
    @patch("lambda_function.get_credentials")
    def test_lambda_handler_when_confirmed_event_ok(self, mock_credentials, mock_send_message, mock_add_user_to_group):
        mock_credentials.return_value = {'bootstrap_servers': 'test_servers', 'users_topic': 'test_topic'}
        file = open(CONFIRMED_EVENT)
        event = json.load(file)
        file.close()

        result = lambda_function.lambda_handler(event, None)

        self.assertEqual(event, result)
        user_event = {
            'firstName': 'test_first_name', 'lastName': 'test_last_name',
            'email': 'test_user@gmail.com', 'userName': 'test_user',
            'phoneNumber': '+14325551212', 'groups': ['tutor']
        }
        mock_send_message.assert_called_once_with('test_servers', 'test_topic', user_event)
        mock_add_user_to_group.assert_called_once_with('tutor', 'test_user', 'us-east-1_00iTBYDqd')

    def test_lambda_handler_when_user_status_not_confirmed(self):
        event = {'triggerSource': 'PostConfirmation_ConfirmSignUp',
                 'request': {'userAttributes': {'cognito:user_status': 'RESET_REQUIRED'}}}

        result = lambda_function.lambda_handler(event, None)

        self.assertEqual(event, result)

    def test_lambda_handler_when_trigger_source_not_post_confirmation(self):
        event = {'triggerSource': 'wrong_source'}

        result = lambda_function.lambda_handler(event, None)

        self.assertEqual(event, result)

    @patch("lambda_function.send_message", **{'return_value.side_effect': Exception()})
    @patch("lambda_function.get_credentials")
    def test_lambda_handler_when_send_message_fails(self, mock_credentials, mock_send_message):
        event = {'triggerSource': 'PostConfirmation_ConfirmSignUp',
                 'request': {'userAttributes': {'cognito:user_status': 'CONFIRMED'}}}
        mock_credentials.return_value = {'bootstrap_servers': 'test_servers', 'users_topic': 'test_topic',
                                         'tutor_group_name': 'tutor'}

        mock_send_message.side_effect = Exception()
        with self.assertRaises(Exception):
            lambda_function.lambda_handler(event, None)

    @patch("lambda_function.get_credentials")
    def test_lambda_handler_when_user_group_is_not_provided(self, mock_credentials):
        event = {'triggerSource': 'PostConfirmation_ConfirmSignUp',
                 'request': {'userAttributes': {'cognito:user_status': 'CONFIRMED'}}}
        mock_credentials.return_value = {'bootstrap_servers': 'test_servers', 'users_topic': 'test_topic',
                                         'tutor_group_name': 'tutor'}

        with self.assertRaises(ValueError) as context:
            lambda_function.lambda_handler(event, None)

    def test_extract_groups(self):
        actual = lambda_function.extract_groups(' tutor, admin ')
        self.assertCountEqual(actual, ['tutor', 'admin'])

    def test_extract_groups_when_single_group_provided(self):
        actual = lambda_function.extract_groups('admin')
        self.assertCountEqual(actual, ['admin'])

    def test_extract_groups_when_blank_then_throw_exception(self):
        with self.assertRaises(ValueError):
            lambda_function.extract_groups('   ')


if __name__ == '__main__':
    file = open(CONFIRMED_EVENT)
    event = json.load(file)
    file.close()

    unittest.main()
