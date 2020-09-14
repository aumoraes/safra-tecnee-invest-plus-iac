import urllib3
import json
from pprint import pprint

class SafraAPI:
    def __init__(self, path, http_method):
        self.path = path
        self.http_method = http_method
        self.base_url = "https://af3tqle6wgdocsdirzlfrq7w5m.apigateway.sa-saopaulo-1.oci.customer-oci.com/fiap-sandbox"
        self.http_client = urllib3.PoolManager()

    def token(self):
        client_secret = "Basic NzBhOTczOTI0YmRkNGRlZmIyMTFiZmQxYzAzMDk3NzE6NTE5NzFlZDUtOTcwNC00NzU3LTkyNGEtZDM0MzFhMmFlNjBk"
        body = "grant_type=client_credentials&scope=urn:opc:resource:consumer::all"
        headers = {
            "authorization": client_secret,
            "content-type": "application/x-www-form-urlencoded"
        }

        
        token_service_url = "https://idcs-902a944ff6854c5fbe94750e48d66be5.identity.oraclecloud.com/oauth2/v1/token"

        resp = self.http_client.request(
            'POST',
            token_service_url,
            body=body,
            headers=headers)

        data = json.loads(resp.data.decode('utf-8'))
        return data['access_token']
    
    def exec(self):
        if "media" in self.path:
            self.path = self.path+"?fromData=2020-07-09&toData=2020-07-14&playlist=morningCalls&channel=safra"
            
        url = f"{self.base_url}{self.path}"
        access_token = self.token()
        access_token = f"Bearer {access_token}"
        headers = {"authorization": access_token}

        response_data = {}
        try:
            response = self.http_client.request(
                self.http_method,
                url,
                headers=headers)

            
            if response.status == 200:
                response_data["Message"] = json.loads(response.data.decode('utf-8'))
                response_data["StatusCode"] = 200
            else:
                response_data["Message"] = response.data.decode('utf-8')
                response_data["StatusCode"] = response.status
            

            return response_data
        except Exception as e:
            pprint(e)
            response_data["Message"] = "Erro no processamento"
            response_data["StatusCode"] = 500
            raise Exception(response_data)


