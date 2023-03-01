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
    vars = { "test_a" : "a", "test_b" : "b" }
    for var in vars.keys():
        os.environ[var] = vars[var]

    lenv = LambdaEnv(list(vars.keys()))
    for var in vars.keys():
        self.assertEqual(vars[var], lenv.value(var))

if __name__ == '__main__':
    unittest.main()