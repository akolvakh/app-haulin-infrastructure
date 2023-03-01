const crypto = require("crypto");

//secret name in secrets manager is created with the same name as the lambda funciton
//lambda @ edge is prefixed with the region, secretName variable is set to the abstract
//lambda function name without the prefix

let AWS = require('aws-sdk'),
    secretName = process.env.AWS_LAMBDA_FUNCTION_NAME;
// lambda@edge must be  hosted in us-east-1 per cryptic AWS limitations. https://github.com/aws/serverless-application-model/issues/635
// also does not lt us use env vars
// laso it is executed (not hosted) in more then one region, givne cloudfront is CDN.. So no point ask AWS for current reiogn to fgiure out where is our serets vault
// @TODO remove hardcode of region! Support multi regional HA
// by string/replace placeholder on deployment // by terraform, as lambda@edge does not support Dockerized labmdas too   
let smClient = new AWS.SecretsManager({region: 'PLACEHOLDER_REGION'});
    
let clientSecret = null;
let userPoolId = null;
let clientId = null;

exports.handler = async (event, context, callback) => {
    
    //Load client secret from secrets manager
    if(clientSecret == null || userPoolId == null || clientId == null){
        
      const promise = new Promise(function(resolve, reject) {
          
          console.log("----------------Loading client secret")
          smClient.getSecretValue({SecretId: secretName}, function(err, data) {
                if (err) {
                    console.error(err);
                    throw err;
                }
                else {
                    let secret = JSON.parse(data.SecretString);
                    clientSecret = secret['client-secret'];
                    userPoolId = secret['userpool-id'];
                    clientId = secret['client-id'];

                }
                
                resolve();
            });
        })
        
        await promise;
        
    }
    
    let request = event.Records[0].cf.request;
    let response = {};
    
    if(request.method === 'POST' && event.Records[0].cf.request.body.data){
        
        let dataJson = JSON.parse(Buffer.from(event.Records[0].cf.request.body.data, 'base64').toString('utf-8'));
        const amzTarget = request.headers && request.headers["x-amz-target"] ? request.headers["x-amz-target"][0].value : null;
        dataJson.ClientId = clientId;
        
        if(amzTarget === 'AWSCognitoIdentityProviderService.InitiateAuth'
            && dataJson.AuthFlow === 'REFRESH_TOKEN_AUTH'){
              
            //Special case for REFRESH_TOKEN_AUTH since username is not part of the request, you only need to pass clientSecret as the secret_hash
            dataJson.AuthParameters.SECRET_HASH = clientSecret;
              
           
        }else if(amzTarget === 'AWSCognitoIdentityProviderService.InitiateAuth'){
            
            const secretHash = crypto.createHmac('SHA256', clientSecret).update(dataJson.AuthParameters.USERNAME + dataJson.ClientId).digest('base64');
            dataJson.AuthParameters.SECRET_HASH = secretHash;
            
            //----------------------------------------------------------------------------------------
            //prepare response object
            response.status = 200;
            response.statusDescription = "ok";
            response.headers = {
                
                /*
                for admin portal  - add here list of env specific domain retreived from parameters
                  'access-control-allow-origin': [{
                    key: 'Access-Control-Allow-Origin',
                    value: '*'
                }],*/
                'content-type': [{
                    key: 'content-type',
                    value: 'application/x-amz-json-1.1'
                }],
                'access-control-expose-headers': [{
                  key: 'access-control-expose-headers',
                  value: 'x-amzn-RequestId,x-amzn-ErrorType,x-amzn-ErrorMessage,Date'
                }]
            };

            //manually send adminInitiateAuth and adminRespondToAuthChallenge calls
            //this logic is to support propagation of client-ip for advanced security risk calculation
            let cognitoidentityserviceprovider = new AWS.CognitoIdentityServiceProvider({region: userPoolId.split('_')[0]});
            const postPromise = new Promise(function(resolve, reject) {
                
                console.log("----------------calling admin auth");
                var params = dataJson;
                if(params.hasOwnProperty('UserContextData')){
                      //https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_InitiateAuth.html#CognitoUserPools-InitiateAuth-request-UserContextData
                      // Contextual data such as the user's device fingerprint, IP address, or location used for evaluating the risk of an unexpected event by Amazon Cognito advanced security.
                      //not supported by AdminInitiateAuth.
                      delete params.UserContextData;
                }
                params.AuthFlow = params.AuthFlow === 'USER_PASSWORD_AUTH' ? 'ADMIN_USER_PASSWORD_AUTH' : params.AuthFlow;
                params.UserPoolId = userPoolId;
                params.ContextData = {
                  HttpHeaders: [ 
                    {
                      headerName: 'User-Agent',
                      headerValue: request.headers["user-agent"][0].value
                    }
                  ],
                  IpAddress: request.clientIp,
                  ServerName: 'https://'+request.origin.custom.domainName,
                  ServerPath: '/'
                };

                cognitoidentityserviceprovider.adminInitiateAuth(params, function(err, data) {
                  if (err) {
                    console.log(err, err.stack); 
                    response.status = err.statusCode;
                    response.statusDescription = err.code;
                    
                    let responseBody = {"__type": err.code ,"message": err.message};
                    response.bodyEncoding = 'base64';
                    response.body = Buffer.from(JSON.stringify(responseBody)).toString('base64');
                    
                    resolve();
                  }else{
                    response.body=JSON.stringify(data);
                    resolve();
                  };
                });
            });
            await postPromise;

            callback(null, response);
            return;
            
        }else if(amzTarget === 'AWSCognitoIdentityProviderService.RespondToAuthChallenge'){
            
            const secretHash = crypto.createHmac('SHA256', clientSecret).update(dataJson.ChallengeResponses.USERNAME + dataJson.ClientId).digest('base64');
            dataJson.ChallengeResponses.SECRET_HASH = secretHash;

            //----------------------------------------------------------------------------------------
            //prepare response object
            response.status = 200;
            response.statusDescription = "ok";
            response.headers = {
                /*'access-control-allow-origin': [{
                    key: 'Access-Control-Allow-Origin',
                    value: '*'
                }],*/
                'content-type': [{
                    key: 'content-type',
                    value: 'application/x-amz-json-1.1'
                }],
                'access-control-expose-headers': [{
                  key: 'access-control-expose-headers',
                  value: 'x-amzn-RequestId,x-amzn-ErrorType,x-amzn-ErrorMessage,Date'
                }]
            };

            //manually send initiateAuth and respondToAuthChallenge calls
            //this logic is to support propagation of client-ip for advanced security risk calculation
            let cognitoidentityserviceprovider = new AWS.CognitoIdentityServiceProvider({region: userPoolId.split('_')[0]});
            const postPromise = new Promise(function(resolve, reject) {
                
                console.log("----------------calling admin respond to auth challenge");
                var params = dataJson;
                if(params.hasOwnProperty('UserContextData')){
                      //https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_InitiateAuth.html#CognitoUserPools-InitiateAuth-request-UserContextData
                      // Contextual data such as the user's device fingerprint, IP address, or location used for evaluating the risk of an unexpected event by Amazon Cognito advanced security.
                      //not supported by AdminRespondToAuthChallenge.
                      delete params.UserContextData;
                }
                params.UserPoolId = userPoolId;
                params.ContextData = {
                  HttpHeaders: [ 
                    {
                      headerName: 'User-Agent',
                      headerValue: request.headers["user-agent"][0].value
                    }
                  ],
                  IpAddress: request.clientIp,
                  ServerName: 'https://'+request.origin.custom.domainName,
                  ServerPath: '/'
                };

                cognitoidentityserviceprovider.adminRespondToAuthChallenge(params, function(err, data) {
                  if (err) {
                    console.log(err, err.stack); resolve();
                    response.status = err.statusCode;
                    response.statusDescription = err.code;
                    let responseBody = {"__type": err.code ,"message": err.message};
                    response.bodyEncoding = 'base64';
                    response.body = Buffer.from(JSON.stringify(responseBody)).toString('base64');  
                    
                  }else{
                    response.body=JSON.stringify(data);
                    resolve();
                  };
                });
            });
            await postPromise;

            callback(null, response);
            return;
            
        }else if(amzTarget === 'AWSCognitoIdentityProviderService.SignUp' || 
                 amzTarget === 'AWSCognitoIdentityProviderService.ConfirmSignUp' || 
                 amzTarget === 'AWSCognitoIdentityProviderService.ForgotPassword' || 
                 amzTarget === 'AWSCognitoIdentityProviderService.ConfirmForgotPassword' || 
                 amzTarget === 'AWSCognitoIdentityProviderService.ResendConfirmationCode' ){
            
            const secretHash = crypto.createHmac('SHA256', clientSecret).update(dataJson.Username + dataJson.ClientId).digest('base64');
            dataJson.SecretHash = secretHash;
            
        }
    
        request.body.action = 'replace';
        request.body.data = Buffer.from(JSON.stringify(dataJson)).toString('base64');

    }

    callback(null, request);
};

