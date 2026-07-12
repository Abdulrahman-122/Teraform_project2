terraform {
  backend "s3" {
        bucket = "gym-tfstate-1234566"
        key = "production/terraform.tfstate"
        region = "eu-west-3"
        use_lockfile = true
        encrypt = true
  }
}