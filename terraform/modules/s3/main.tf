# aws s3 bucket
resource "aws_s3_bucket" "upload_bucket"{
    bucket = var.bucket_name
}

# s3 bucket policy document
data "aws_iam_policy_document" "s3_bucket_access_policy_document" {
    statement{
        effect = "Allow"
        actions = [
            "s3:PutObject",
            "s3:GetObject"
        ]
        resources = [
            aws_s3_bucket.upload_bucket.arn,
            "${aws_s3_bucket.upload_bucket.arn}/*"
        ]
    }
}

# s3 bucket policy
resource "aws_iam_policy" "s3_bucket_access_policy"{
    name = "${var.s3_bucket_access_policy_name}-${var.bucket_name}"
    description = "Policy to allow access to S3 bucket ${var.bucket_name}"
    policy = data.aws_iam_policy_document.s3_bucket_access_policy_document.json
}

# attach policy to user
resource "aws_iam_user_policy_attachment" "s3_upload_user_policy_attachment" {
    user       = var.user_name
    policy_arn = aws_iam_policy.s3_bucket_access_policy.arn
}

# grant s3 permission to invoke lambda
resource "aws_lambda_permission" "s3_invoke_lambda" {
    statement_id  = "AllowS3Invoke"
    action        = "lambda:InvokeFunction"
    function_name = var.lambda_function_arn
    principal     = "s3.amazonaws.com"

    # The source ARN is the ARN of the S3 bucket
    source_arn = aws_s3_bucket.upload_bucket.arn
}

# configure s3 notifications to trigger lambda
resource "aws_s3_bucket_notification" "s3_lambda_notification" {
    bucket = aws_s3_bucket.upload_bucket.id

    lambda_function {
        lambda_function_arn = var.lambda_function_arn
        events              = ["s3:ObjectCreated:*"]
    }

    depends_on = [
        aws_lambda_permission.s3_invoke_lambda
    ]
}

# create a log group
resource "aws_cloudwatch_log_group" "s3_upload_log_group" {
    name              = "/aws/s3/${var.lambda_function_name}/upload"
    
    depends_on = [
        var.lambda_function
    ]
}