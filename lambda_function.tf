resource "aws_lambda_function" "lambda_function_api_service" {
  filename         = data.archive_file.zip_lambda_function.output_path
  source_code_hash = data.archive_file.zip_lambda_function.output_base64sha256
  function_name = local.aws_lambda_name
  role          = aws_iam_role.role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10
}

resource "aws_lambda_function" "lambda_function_safra_bot_service" {
  filename         = data.archive_file.zip_safra_bot_function.output_path
  source_code_hash = data.archive_file.zip_safra_bot_function.output_base64sha256
  function_name = local.aws_lambda_safra_bot_name
  role          = aws_iam_role.role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10
}


resource "aws_lambda_function" "lambda_api_authorizer" {
  filename         = data.archive_file.zip_lambda_api_authorizer.output_path
  source_code_hash = data.archive_file.zip_lambda_api_authorizer.output_base64sha256
  function_name = local.aws_lambda_authorizer_name
  role          = aws_iam_role.role_for_lambda.arn
  handler       = "lambda_api_authorizer.handler"
  runtime       = "nodejs12.x"
  timeout       = 10
}