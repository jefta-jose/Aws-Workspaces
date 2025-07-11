# dev environment
terraform {
    backend "s3" {
      bucket = "multi-environments-dev"
      key = "terraform/state"
      region = "us-east-1"
      encryption = true
    }
    
}