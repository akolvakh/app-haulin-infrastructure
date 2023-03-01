def lambda_handler(event, context):
        response = event["Records"][0]["cf"]["response"]
        headers = response["headers"]
        
        headers["cache-control"] = [
                {
                  "key": "Cache-Control",
                  "value": "public, max-age=432000"
                }
        ]
        
        return response
    