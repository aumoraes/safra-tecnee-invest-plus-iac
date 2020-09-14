from pprint import pprint

class InvestmentSuggestion:
    
    def __init__(self, account):
        self.account = account
    
    
    def get_suggestion(self):
        
        
        if InvestmentProfileEnum.CONSERVADOR.value in self.account.investor_profile:
            
            responseBody = {}

            category_list = []
            data = {}
            data_list_tesouro_diretor = ["Tesouro IPCA 2026+", "Tesouro IPCA 2035+", "Tesouro Selic 2025"]
            data['Categoria'] = "Tesouro Direto"
            data['NomeAtivo'] = data_list_tesouro_diretor

            category_list.append(data)


            responseBody['Suggestions'] = category_list

        elif InvestmentProfileEnum.MODERADO.value in  self.account.investor_profile: 
            
            responseBody = {}

            category_list = []
            
            data1 = {}
            data_list_tesouro_diretor = ["Tesouro IPCA 2026+", "Tesouro Selic 2025"]
            data1['Categoria'] = "Tesouro Direto"
            data1['NomeAtivo'] = data_list_tesouro_diretor

            data2 = {}
            data_list_tesouro_diretor = ["HGLG11", "XPML11", "XPLG11"]
            data2['Categoria'] = "Fundos Imobiliarios"
            data2['NomeAtivo'] = data_list_tesouro_diretor

            category_list.append(data1)
            category_list.append(data2)


            responseBody['Suggestions'] = category_list

        elif InvestmentProfileEnum.AGRESSIVO.value in  self.account.investor_profile:
            
            responseBody = {}

            category_list = []
            
            data1 = {}
            data_list_tesouro_diretor = ["SAFRA ACOES LIVRE FIC FIA", "SAFRA CONSUMO AMERICANO FIC AC", "SAFRA SELECTION FIC ACOES"]
            data1['Categoria'] = "Fundo Acoes"
            data1['NomeAtivo'] = data_list_tesouro_diretor

            data2 = {}
            data_list_tesouro_diretor = ["HGLG11", "XPML11"]
            data2['Categoria'] = "Fundos Imobiliarios"
            data2['NomeAtivo'] = data_list_tesouro_diretor

            category_list.append(data1)
            category_list.append(data2)


            responseBody['Suggestions'] = category_list

        else:
            responseBody = {}

            category_list = []
            data = {}
            data_list_tesouro_diretor = ["Tesouro IPCA 2026+", "Tesouro IPCA 2035+", "Tesouro Selic 2025"]
            data['Categoria'] = "Tesouro Direto"
            data['NomeAtivo'] = data_list_tesouro_diretor

            category_list.append(data)


            responseBody['Suggestions'] = category_list

        return responseBody
        


from enum import Enum
class InvestmentProfileEnum(Enum):
    CONSERVADOR = "Conservador"
    MODERADO = "Moderado"
    AGRESSIVO = "Agressivo"