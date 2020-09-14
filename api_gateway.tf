resource "aws_api_gateway_rest_api" "api_gateway_api" {
  name        = local.aws_api_gateway_name
  description = "Query a DynamoDB Table for values"
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_api.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_api.root_resource_id
  path_part   = "{proxy+}"
}
resource "aws_api_gateway_method" "api_gateway_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_api.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.apigw_authorizer.id
}
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_api.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.api_gateway_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function_api_service.arn}/invocations"
}
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_api_service.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "api_gateway_resource_safra_bot" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_api.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_api.root_resource_id
  path_part   = "safra-bot"
}
resource "aws_api_gateway_method" "api_gateway_get_safra_bot" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_api.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource_safra_bot.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.apigw_authorizer.id
}
resource "aws_api_gateway_integration" "integration_safra_bot" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_api.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource_safra_bot.id
  http_method             = aws_api_gateway_method.api_gateway_get_safra_bot.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function_safra_bot_service.arn}/invocations"
}
resource "aws_lambda_permission" "apigw_lambda_safra_bot" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_safra_bot_service.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_api.execution_arn}/*/*"
}
resource "aws_api_gateway_authorizer" "apigw_authorizer" {
  name                   = "apigw_authorizer"
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_api.id
  authorizer_uri         = aws_lambda_function.lambda_api_authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role_apigw.arn
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  #depends_on = [aws_api_gateway_integration.integration, aws_api_gateway_integration.integration_greedy_path]
  depends_on = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway_api.id
  stage_name  = "production"
}

