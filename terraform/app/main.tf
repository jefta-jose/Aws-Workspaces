locals {
  user_name               = "jeff-ndegwa-254-${var.environment}-user"
  bucket_name             = "jeff-ndegwa-254-${var.environment}-s3-bucket"
  s3_bucket_access_policy_name = "jeff-ndegwa-254-${var.environment}-s3-policy"
  lambda_function_name    = "jeff-ndegwa-254-${var.environment}-lambda-function"
  lambda_invoke_role_name = "jeff-ndegwa-254-${var.environment}-lambda-invoke-role"
}


module "iam_user"{
    source = "../../../../../modules/iam_user"
    user_name = local.user_name
}

module "lambda_function"{
    source = "../../../../../modules/lambda"
    lambda_function_name = local.lambda_function_name
    lambda_invoke_role_name = local.lambda_invoke_role_name
}

module "s3_bucket"{
    source = "../../../../../modules/s3"
    bucket_name = local.bucket_name
    s3_bucket_access_policy_name = local.s3_bucket_access_policy_name
    user_name = module.iam_user.s3_upload_user_name
    lambda_function_arn = module.lambda_function.lambda_function_arn
    lambda_function_name = module.lambda_function.lambda_function_name
    lambda_function = module.lambda_function.lambda_function
}