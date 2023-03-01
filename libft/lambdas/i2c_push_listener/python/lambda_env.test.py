import os
import unittest

from lambda_env import LambdaEnv


class TestFunction(unittest.TestCase):
    def test_missing_environment_variable(self):
        try:
            del os.environ['test_a']
        except:
            pass

        with self.assertRaises(KeyError):
            LambdaEnv(["test_a"])

    def test_multiple_environment_variables(self):
        variables = {"test_a": "a", "test_b": "b"}
        for var in variables.keys():
            os.environ[var] = variables[var]

        lenv = LambdaEnv(list(variables.keys()))
        for var in variables.keys():
            self.assertEqual(variables[var], lenv.value(var))


if __name__ == '__main__':
    unittest.main()
