# each environment will have its own state file

#dev
terraform {
    backend "s3" {
      bucket = "multi-environments-dev"
      key = "terraform/state"
      region = "us-east-1"
      encryption = true
    }
    
}

#staging
terraform {
    backend "s3" {
      bucket = "multi-environments-staging"
      key = "terraform/state"
      region = "us-east-1"
      encryption = true
    }
    
}

#prod
terraform {
    backend "s3" {
      bucket = "multi-environments-prod"
      key = "terraform/state"
      region = "us-east-1"
      encryption = true
    }
    
}