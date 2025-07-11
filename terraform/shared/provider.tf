# aws provider

data "aws_region" "current" {}

provider "aws"{
    region = "us-east-1"
}