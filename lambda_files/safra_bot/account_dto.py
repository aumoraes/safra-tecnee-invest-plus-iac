from pprint import pprint
class AccountDTO:

  def __init__(self, data):
    self.data = data
    self.age = self.data["Accounts"][0]["Age"]
    self.name = self.data["Accounts"][0]["Name"]
    self.investor_profile = self.data["Accounts"][0]["InvestorProfile"]