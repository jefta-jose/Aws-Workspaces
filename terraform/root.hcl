remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terragrunt-multi-environments-jefta"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    provider "aws" {
      region = "us-east-1"
    }
    EOF
}