##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_dynamodb_account_table_name" {}
variable "aws_dynamodb_wallet_table_name" {}
variable "aws_lambda_name" {}
variable "aws_lambda_safra_bot_name" {}
variable "aws_lambda_authorizer_name" {}
variable "aws_api_gateway_name" {}

variable "region" {
  default = "us-east-1"
}
variable "prefix_name"{
  default = "safra_tecnee"
}
