required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }
}

provider "aws" "s3" {
  config {
    region = "us-east-1"
  }
}