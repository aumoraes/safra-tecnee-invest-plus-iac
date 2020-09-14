import json
import urllib3
import json
from pprint import pprint
from account_dto import AccountDTO
from investment_suggestion import InvestmentSuggestion

def lambda_handler(event, context):

    status_code = 200
    message = "OK"

    try:

        client_secret = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic2FmcmEtc2VjcmV0IiwianRpIjoiMTcwNjBkMzktZTc3Yi00Y2YxLTgxYWUtNGY4MmM0ODg3NjMxIiwiaWF0IjoxNTk5ODgyNDI2LCJleHAiOjE1OTk4ODYwMjZ9.f-LhhN5uLcpVCGldireDayaAJsfSWhYlxI11wAinIac"
        http_client = urllib3.PoolManager()

        headers = {
            "authorization": client_secret,
            "content-type": "application/x-www-form-urlencoded"
        }

        client_id = event['path'].split("/")[-1]
        
        
        url = f"https://wlrfkvp3g5.execute-api.us-east-1.amazonaws.com/production/invest-plus/v1/accounts/{client_id}"

        response = http_client.request(
                'GET',
                url,
                headers=headers)

        
        data = json.loads(response.data.decode('utf-8'))
        
        

        account_dto = AccountDTO(data)
        
        investment_suggestion = InvestmentSuggestion(account_dto)
        
        
        
        message = investment_suggestion.get_suggestion()
        
    except Exception as e:
        status_code = 500
        pprint(str(e))
        message = "O safra bot encontrou um erro, por favor, tente novamente mais tarde"

    return {
            "isBase64Encoded": False,
            "statusCode": status_code,
            "headers": {},
            "body": json.dumps(message)
        }