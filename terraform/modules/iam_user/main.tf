# s3 upload user

resource "aws_iam_user" "s3_upload_user" {
    name = var.user_name
}