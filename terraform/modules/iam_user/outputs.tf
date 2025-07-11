# user to attach to s3 bucket access policy
output "s3_upload_user_name" {
    value = aws_iam_user.s3_upload_user.name
}