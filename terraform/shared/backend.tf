# each environment will have its own state file

terraform {
    backend "s3" {
      bucket = ""
    }
    
}