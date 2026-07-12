terraform {
  required_providers {
    aws={
        version = "~> 5.92"
        source="hashicorp/aws"
    }
  }
  required_version = "1.15.7"
}
provider "aws" {
  region=var.region
}

