required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.12.0"
  }
}

provider "aws" "s3" {
  config {
    region = "eu-north-1"
  }
}