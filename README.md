# Safra Tecnee - Invest Plus - iac

## Invest Plus
Invest Plus é uma nova solução para o mercado de investimento.

Toda infra foi pensada baseada em ambiente cloud, tendo como principal utilização AWS.

Os recursos utilizados são:
- API Gateway
- Lambda

### Como executar

Na pasta do projeto:
```
terraform init
terraform plan -out iac.tfplan
terraform apply iac.tfplan
```

![invest plus arquitetura](https://github.com/aumoraes/safra-tecnee-invest-plus-iac/blob/master/arquitetura-insvest-plus.png)


para saber mais:
[Terraform](https://www.terraform.io/) | 
[AWS](https://aws.amazon.com/pt/)





