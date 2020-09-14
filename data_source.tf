##################################################################################
# DATA
##################################################################################

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "archive_file" "zip_lambda_function" {
  type        = "zip"
  source_dir = "${path.module}/lambda_files/lambda_function/"
  output_path = "${path.module}/lambda_files/lambda_function/lambda_function.zip"
}

data "archive_file" "zip_safra_bot_function" {
  type        = "zip"
  source_dir = "${path.module}/lambda_files/safra_bot/"
  output_path = "${path.module}/lambda_files/safra_bot/safra_bot.zip"
}


data "archive_file" "zip_lambda_api_authorizer" {
  type        = "zip"
  source_file = "${path.module}/lambda_files/lambda_api_authorizer/lambda_api_authorizer.js"
  output_path = "${path.module}/lambda_files/lambda_api_authorizer/lambda_api_authorizer.zip"
}

data "template_file" "dynamo_data_account_01" {
  template = "${file("templates/dynamodb/account-01.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_01_01" {
  template = "${file("templates/dynamodb/wallet-01-01.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_01_02" {
  template = "${file("templates/dynamodb/wallet-01-02.tpl")}"
  vars = {}
}


data "template_file" "dynamo_data_account_02" {
  template = "${file("templates/dynamodb/account-02.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_02_01" {
  template = "${file("templates/dynamodb/wallet-02-01.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_02_02" {
  template = "${file("templates/dynamodb/wallet-02-02.tpl")}"
  vars = {}
}

data "template_file" "dynamo_data_account_03" {
  template = "${file("templates/dynamodb/account-03.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_03_01" {
  template = "${file("templates/dynamodb/wallet-03-01.tpl")}"
  vars = {}
}
data "template_file" "dynamo_data_wallet_03_02" {
  template = "${file("templates/dynamodb/wallet-03-02.tpl")}"
  vars = {}
}