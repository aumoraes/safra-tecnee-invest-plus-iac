output "dynamodb_account_prod" {
  value = aws_dynamodb_table.dynamodb_account_prod.name
}
output "dynamodb_wallet_prod" {
  value = aws_dynamodb_table.dynamodb_wallet_prod.name
}


output "lambda_function" {
  value = aws_lambda_function.lambda_function_api_service.arn
}

output "invoke-url" {
  value = "https://${aws_api_gateway_deployment.api_gateway_deployment.rest_api_id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_deployment.api_gateway_deployment.stage_name}/${aws_api_gateway_resource.api_gateway_resource.path_part}"
  description = "api service endpoint"
}

