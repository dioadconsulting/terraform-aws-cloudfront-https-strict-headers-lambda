output "lambda_arn" {
  value = aws_lambda_function.strict_headers.arn
}
output "lambda_qualified_arn" {
  value = aws_lambda_function.strict_headers.qualified_arn
}

output "lambda_function_name" {
  value = "${local.lambda_function_name}"
}