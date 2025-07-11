# variables 
variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
}

variable "s3_bucket_access_policy_name" {
    description = "The name of the S3 bucket access policy"
    type        = string
}

variable "user_name" {
    description = "The name of the IAM user for S3 uploads"
    type        = string
}

variable "lambda_function_arn" {
    description = "The ARN of the Lambda function"
    type        = string
}

variable "lambda_function_name" {
    description = "The name of the Lambda function"
    type        = string
}

variable "lambda_function"{
    description = "The Lambda function resource"
    type        = any
}