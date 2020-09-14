resource "aws_iam_policy" "dynamodb-access" {
  name = "dynamodb-access"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:Get*",
                "dynamodb:query",
                "dynamodb:scan"
            ],
            "Resource": [
              "${aws_dynamodb_table.dynamodb_account_prod.arn}",
              "${aws_dynamodb_table.dynamodb_wallet_prod.arn}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "role_for_lambda" {
  name = "role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "dynamodb-access" {
  role       = aws_iam_role.role_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb-access.arn
}


resource "aws_iam_role" "invocation_role_apigw" {
  name = "api_gateway_auth_invocation"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "invocation_policy_apigw"
  role = aws_iam_role.invocation_role_apigw.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.lambda_api_authorizer.arn}"
    }
  ]
}
EOF
}
