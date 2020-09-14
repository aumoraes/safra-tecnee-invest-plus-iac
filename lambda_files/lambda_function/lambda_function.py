from router import Router
import json
def lambda_handler(event, context):

    router = Router(event['path'], event['httpMethod'])

    
    message = ""
    status_code = 200
    try:
        response = router.call()
        message = response["Message"]
        status_code = response["StatusCode"]
    except Exception as e:
        message = str(e)
        status_code = 500

    
    return {
        "isBase64Encoded": False,
        "statusCode": status_code,
        "headers": {},
        "body": json.dumps(message)
    }