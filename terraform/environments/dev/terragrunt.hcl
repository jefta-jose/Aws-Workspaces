include "root" {
    path = find_in_parent_folders("root.hcl")
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terragrunt-multi-environments-jefta"
    key = "terraform/state"
    region = "us-east-1"
    encrypt = true
  }
}
