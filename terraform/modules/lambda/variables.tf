# variables

variable "lambda_function_name" {
    description = "The name of the Lambda function"
    type        = string
}

variable "lambda_invoke_role_name" {
    description = "The name of the IAM role for Lambda invocation"
    type        = string
}