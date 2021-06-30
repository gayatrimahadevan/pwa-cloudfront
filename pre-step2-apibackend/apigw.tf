resource "aws_api_gateway_rest_api" "ta-wp-test" {
  name        = "RestApiQuotes"
  description = "REST API Application Sample."
  tags = merge(
    {
      Name = "RestApiQuotes"
    }
  )
}
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.ta-wp-test.id
  resource_id   = aws_api_gateway_rest_api.ta-wp-test.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "cors" {
  depends_on = [aws_api_gateway_method.proxy_root]
  rest_api_id = aws_api_gateway_rest_api.ta-wp-test.id
  resource_id = aws_api_gateway_rest_api.ta-wp-test.root_resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
}
resource "aws_lambda_alias" "dev" {
  name             = "dev"
  description      = "Development version."
  function_name    = aws_lambda_function.get-random-quotes.arn
  function_version = var.deploy_to_prod ? "6" : "$LATEST"
}
resource "aws_lambda_alias" "prod" {
  name             = "prod"
  description      = "Production version."
  function_name    = aws_lambda_function.get-random-quotes.arn
  function_version = var.deploy_to_prod ?  "$LATEST": "$LATEST" 
}
resource "aws_api_gateway_integration" "lambda_dev" {
  rest_api_id = aws_api_gateway_rest_api.ta-wp-test.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_alias.dev.invoke_arn
}
resource "aws_api_gateway_integration" "lambda_prod" {
  rest_api_id = aws_api_gateway_rest_api.ta-wp-test.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_alias.prod.invoke_arn
}
resource "aws_api_gateway_deployment" "prod" {
  depends_on = [aws_api_gateway_integration.lambda_prod]
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.lambda_prod,
    ]))
  }
  rest_api_id = aws_api_gateway_rest_api.ta-wp-test.id
  stage_name  = "prod"
}
resource "aws_api_gateway_deployment" "dev" {
  depends_on = [aws_api_gateway_integration.lambda_dev]
  rest_api_id = aws_api_gateway_rest_api.ta-wp-test.id
  stage_name  = "dev"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-random-quotes.function_name
  qualifier     = aws_lambda_alias.dev.name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.ta-wp-test.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigwprod" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-random-quotes.function_name
  qualifier     = aws_lambda_alias.prod.name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.ta-wp-test.execution_arn}/*/*"
}
resource "aws_api_gateway_gateway_response" "response_4xx" {
  rest_api_id   = aws_api_gateway_rest_api.ta-wp-test.id
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/json" = "{'message':$context.error.messageString}"
  }
  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'*'" # replace with hostname of frontend (CloudFront)
  }
}
resource "aws_api_gateway_gateway_response" "response_5xx" {
  rest_api_id   = aws_api_gateway_rest_api.ta-wp-test.id
  response_type = "DEFAULT_5XX"

  response_templates = {
    "application/json" = "{'message':$context.error.messageString}"
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'*'" # replace with hostname of frontend (CloudFront)
  }
}
