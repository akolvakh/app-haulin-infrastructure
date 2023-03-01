import os

class LambdaEnv:
    def __init__(self, required_env_vars = []):
        self.env = {}
        for env_var in required_env_vars:
            try:
                self.env[env_var] = os.environ[env_var]
            except KeyError:
                raise KeyError("Required environment variable \"%s\" must be defined" % (env_var))
            
    def value(self, env_var):
        return self.env[env_var]
        