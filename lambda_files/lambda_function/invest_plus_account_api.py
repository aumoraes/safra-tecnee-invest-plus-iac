import json
import boto3
import re

class InvestPlusAccountAPI:
    
    def __init__(self, path, http_method):
        self.path = path
        self.http_method = http_method
        self.table_name = "safra_tecnee_account"
    
    def get_accounts(self):
        
        client = boto3.client('dynamodb')

        response = client.scan(
            TableName=self.table_name,
            Select='ALL_ATTRIBUTES'
        )

        return self.prepare_response(response)
        
    def get_account_by_id(self, account_id):
        client = boto3.client('dynamodb')

        response = client.query(
            TableName=self.table_name,
            Select='ALL_ATTRIBUTES',
            ExpressionAttributeValues= {
                    ':p': {'S': account_id},
                },
            KeyConditionExpression= 'AccountId = :p'
            )
        return self.prepare_response(response)
    
    def prepare_response(self, response):
        responseBody = {}
        data_list = []
        for item in response['Items']:
            data = {}
            data['AccountId'] = item['AccountId']['S']
            data['Currency'] = item['Currency']['S']
            data['Nickname'] = item['Nickname']['S']
            data['Name'] = item['Name']['S']
            data['Identification'] = item['Identification']['S']
            data['Age'] = item['Age']['N']
            data['Investor'] = item['Investor']['S']
            data['InvestorProfile'] = item['InvestorProfile']['S']
            data['Amount'] = item['Amount']['S']
            data['PorcentagemAcoes'] = item['PorcentagemAcoes']['S']
            data['PorcentagemFIIs'] = item['PorcentagemFIIs']['S']
            data['SafraCoins'] = item['SafraCoins']['S']

            data_list.append(data)
        
        responseBody['Accounts'] = data_list
        

        return responseBody
