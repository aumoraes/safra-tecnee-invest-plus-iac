import json
import boto3
import re

class InvestPlusWalletAPI:
    
    def __init__(self, path, http_method):
        self.path = path
        self.http_method = http_method
        self.table_name = "safra_tecnee_wallet"

    def get_wallets(self):
        
        client = boto3.client('dynamodb')

        response = client.scan(
            TableName=self.table_name,
            Select='ALL_ATTRIBUTES'
        )

        return self.prepare_response(response)
        
    def get_wallets_by_id(self, account_id):
        client = boto3.client('dynamodb')

        response = client.scan(
            TableName=self.table_name,
            Select='ALL_ATTRIBUTES',
            FilterExpression="AccountId = :account_id",
            ExpressionAttributeValues={ ':account_id': {"S": account_id}}

            #ExpressionAttributeValues= {
            #        ':p': {'S': account_id},
            #    },
            #KeyConditionExpression= 'AccountId = :p'
            )
        return self.prepare_response(response)
    
    def prepare_response(self, response):
        responseBody = {}
        data_list = []
        for item in response['Items']:
            data = {}
            data['WalletId'] = item['WalletId']['S']
            data['InvestmentId'] = item['InvestmentId']['S']
            data['AccountId'] = item['AccountId']['S']
            data['NomeAtivo'] = item['NomeAtivo']['S']
            data['Percentage'] = item['Percentage']['S']

            data_list.append(data)
        
        responseBody['Wallets'] = data_list
        

        return responseBody
