resource "aws_dynamodb_table" "dynamodb_account_prod" {
  name           = local.aws_dynamodb_account_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "AccountId"

  attribute {
    name = "AccountId"
    type = "S"
  }
}
resource "aws_dynamodb_table" "dynamodb_wallet_prod" {
  name           = local.aws_dynamodb_wallet_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "InvestmentId"

  attribute {
    name = "InvestmentId"
    type = "S"
  }
}


resource "aws_dynamodb_table_item" "dynamodb_prod_data_account_01" {
  table_name = aws_dynamodb_table.dynamodb_account_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_account_prod.hash_key

  item = data.template_file.dynamo_data_account_01.rendered 
}
resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_01_01" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_01_01.rendered 
}
resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_01_02" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_01_02.rendered 
}

resource "aws_dynamodb_table_item" "dynamodb_prod_data_account_02" {
  table_name = aws_dynamodb_table.dynamodb_account_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_account_prod.hash_key

  item = data.template_file.dynamo_data_account_02.rendered
  
}
resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_02_01" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_02_01.rendered 
}
resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_02_02" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_02_02.rendered 
}


resource "aws_dynamodb_table_item" "dynamodb_prod_data_account_03" {
  table_name = aws_dynamodb_table.dynamodb_account_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_account_prod.hash_key

  item = data.template_file.dynamo_data_account_03.rendered
  
}

resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_03_01" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_03_01.rendered 
}
resource "aws_dynamodb_table_item" "dynamodb_prod_data_wallet_03_02" {
  table_name = aws_dynamodb_table.dynamodb_wallet_prod.name
  hash_key   = aws_dynamodb_table.dynamodb_wallet_prod.hash_key

  item = data.template_file.dynamo_data_wallet_03_02.rendered 
}