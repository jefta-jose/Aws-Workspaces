# dev environment 

module "iam_user"{
    source = "../../modules/iam_user"
    user_name = "dev-user"
}

module "lambda_function"{
    source = "../../modules/lambda"
    lambda_function_name = "dev-lambda-function"
}

module "s3_bucket"{
    source = "../../modules/s3_bucket"
    bucket_name = "dev-s3-bucket"
    s3_bucket_access_policy_name = "dev-s3-policy"
    user_name = module.iam_user.s3_upload_user_name
    lambda_function_arn = module.lambda_function.lambda_function_arn
    lambda_function_name = module.lambda_function.lambda_function_name
    lambda_function = module.lambda_function.lambda_function
}