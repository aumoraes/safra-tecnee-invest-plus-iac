import json
import boto3
import re
from invest_plus_account_api import InvestPlusAccountAPI  
from invest_plus_wallet_api import InvestPlusWalletAPI
class InvestPlusAPI:
    
    def __init__(self, path, http_method):
        self.path = path
        self.http_method = http_method
        self.table_name = "safra_tecnee_account"
        self.invest_plus_account_api = InvestPlusAccountAPI(path, http_method)
        self.invest_plus_wallet_api = InvestPlusWalletAPI(path, http_method)

    def exec(self):
        response_data = {}
        if "/invest-plus/v1/accounts" == self.path:
            response_data["Message"] = self.invest_plus_account_api.get_accounts()
            response_data["StatusCode"] = 200
        elif re.search("/invest-plus/v1/accounts/\d+$", self.path):
            response_data["Message"] = self.invest_plus_account_api.get_account_by_id(self.path.split("/")[-1])
            response_data["StatusCode"] = 200
        elif "/invest-plus/v1/wallets" == self.path:
            response_data["Message"] = self.invest_plus_wallet_api.get_wallets()
            response_data["StatusCode"] = 200
        elif re.search("/invest-plus/v1/wallets/\d+$", self.path):
            response_data["Message"] = self.invest_plus_wallet_api.get_wallets_by_id(self.path.split("/")[-1])
            response_data["StatusCode"] = 200
        else:
            response_data["Message"] = "404 - Not Found"
            response_data["StatusCode"] = 404

        return response_data