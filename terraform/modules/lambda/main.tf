# aws IAM role to invoke lambda
resource "aws_iam_role" "lambda_invoke_role" {
    name = "${var.lambda_invoke_role_name}-lambda-role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

# attach role to an execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
    role       = aws_iam_role.lambda_invoke_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# archive the source code
data "archive_file" "lambda_source" {
    type        = "zip"
    source_file = "${path.module}/../../../index.js"
    output_path = "${path.module}/../../../lambda.zip"
}

# lambda function
resource "aws_lambda_function" "lambda_function"{
    function_name = var.lambda_function_name
    role = aws_iam_role.lambda_invoke_role.arn
    handler = index.handler
    runtime = "nodejs18.x"
    filename = data.archive_file.lambda_source.output_path

    depends_on = [
        aws_iam_role_policy_attachment.lambda_basic_execution
    ]
}

