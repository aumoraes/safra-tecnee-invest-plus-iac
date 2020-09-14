import json
import boto3

from safra_api_facade import SafraAPI
from invest_plus_api import InvestPlusAPI

class Router:
    
    def __init__(self, path, http_method):
      self.path = path
      self.http_method = http_method

    def call(self):
      response = ""
      if Routes.INVEST_PLUS.value in self.path:
        response = self.invest_plus(self.path, self.http_method)
      else:
        response = self.safra_api(self.path, self.http_method)

      return response
    
    def invest_plus(self, path, http_method):
      invest_plus_api = InvestPlusAPI(path, http_method)
      return invest_plus_api.exec()

    def safra_api(self, path, http_method):
      safra_api = SafraAPI(path, http_method)
      return safra_api.exec()


from enum import Enum
class Routes(Enum):
    INVEST_PLUS = "invest-plus"