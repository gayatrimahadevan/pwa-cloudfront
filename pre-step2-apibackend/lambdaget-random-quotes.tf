resource "aws_iam_role" "example" {
  name = "serverless_example_lambda"

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
resource "aws_lambda_function" "get-random-quotes" {
  depends_on       = [null_resource.push]
  function_name    = "get-random-quotes"
  role             = aws_iam_role.example.arn
  package_type	   = "Image"
  image_uri        = var.image_uri
  publish          = true
  tags = merge(
    {
      Name = "get-random-quotes"
    }
  )
}
