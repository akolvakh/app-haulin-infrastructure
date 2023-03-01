# Lambdas
lambda functions used in AWS infrastructure

# Directory Structure
/LANGUAGE/LAMBDA - e.g. python/i2c_web_request


## Please document Lambda functions here
| Directory                             |  Description                                                |
|---------------------------------------|-------------------------------------------------------------|
|lambda-triggers/post-confirmation      | Post confirmation lambda for creating user                  |
|i2c_web_request                 | I2C web request lambda                                      | 
| cognito-preauthorization       | force update lambda that check latest mobile version supported and throw exception if version is outdated  
| cognito-presignup  | pre signup lambda that can request early access for user and validate early access