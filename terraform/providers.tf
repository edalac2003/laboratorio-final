terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "laboratoriofinal.itm"
    key = "terraform.tfstate"
    region = "us-east-1"
    profile = "itmlab30"
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "itmlab30"
}