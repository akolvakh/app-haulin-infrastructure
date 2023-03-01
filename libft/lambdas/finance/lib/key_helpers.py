import logging

def boto_s3_client():
    import boto3

    session = boto3.session.Session()
    logging.info("Creating boto s3 client session in region: " + session.region_name)
    return session.client(service_name='s3', region_name = session.region_name)

def ssm_get_parameters(names):
    import boto3

    session = boto3.session.Session()
    logging.info("Creating boto ssm client session in region: " + session.region_name)
    ssm = session.client(service_name='ssm', region_name = session.region_name)
    return ssm.get_parameters(Names=names)['Parameters']

def get_sftp_connection(hostname, username, port, private_key_file, private_key_pass):
    import pysftp

    # TODO: load hostkeys
    cnopts = pysftp.CnOpts()
    cnopts.hostkeys = None
    
    return pysftp.Connection(hostname, 
                             username=username, 
                             private_key=private_key_file, 
                             port=int(port), 
                             private_key_pass=private_key_pass,
                             cnopts = cnopts)

def get_private_key_file(key_param_name):
    import os

    private_key_file = '/tmp/{}'.format(key_param_name)
    
    if not os.path.exists(private_key_file):
        private_key = ssm_get_parameters([key_param_name])[0]['Value']
        with open(private_key_file, "w") as kf:
            kf.write(private_key)
        
    return private_key_file

def get_private_key_passphrase(secret_name):
    import secrets_manager
    import jsonpickle

    secret_string = secrets_manager.get_secret(secret_name)
    secret_string_json = jsonpickle.decode(secret_string)
    return secret_string_json['passphrase']

