# staging environment
terraform {
    backend "s3" {
      bucket = "multi-environments-staging"
      key = "terraform/state"
      region = "us-east-1"
      encryption = true
    }
    
}