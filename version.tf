terraform {
  backend "s3" {
    profile = "terraformprofile"
    bucket  = "cyware-terraformstatefile"
    key     = "cyware/dev"
    region  = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}
