##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  version = "~>2.0"
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
  region     = var.region
}

locals{
  aws_dynamodb_account_table_name = "${var.prefix_name}_${var.aws_dynamodb_account_table_name}"
  aws_dynamodb_wallet_table_name = "${var.prefix_name}_${var.aws_dynamodb_wallet_table_name}"
  aws_lambda_name = "${var.prefix_name}-${var.aws_lambda_name}"
  aws_lambda_safra_bot_name = "${var.prefix_name}-${var.aws_lambda_safra_bot_name}"
  aws_lambda_authorizer_name = "${var.prefix_name}-${var.aws_lambda_authorizer_name}"
  aws_api_gateway_name = "${var.prefix_name}-${var.aws_api_gateway_name}"
}