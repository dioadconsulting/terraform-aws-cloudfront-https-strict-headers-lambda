locals {
  suffix               = var.suffix != "" ? "-${replace(var.suffix, ".", "_")}" : ""
  lambda_function_name = "${var.prefix}CloudfrontStrictHTTPSHeaders${local.suffix}"

}


data "aws_iam_policy_document" "lambda_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    sid     = "AllowLambda"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "strict_headers" {
  name = "${var.prefix}CloudfrontLambdaStrictHeaders${local.suffix}"

  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

resource "aws_lambda_function" "strict_headers" {
  filename      = data.archive_file.strict_headers.output_path
  function_name = "${local.lambda_function_name}"
  role          = "${aws_iam_role.strict_headers.arn}"
  handler       = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = data.archive_file.strict_headers.output_base64sha256

  runtime = "nodejs8.10"

  publish = true
}
