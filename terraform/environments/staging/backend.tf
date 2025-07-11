# prod environment
terraform {
    backend "s3" {
      bucket = "multi-environments-prod"
      key = "terraform/state"
      region = "us-east-1"
      encrypt = true
    }
    
}