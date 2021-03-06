terraform {
  backend "s3" {
    bucket         = "ssr-web-terraform-state-prod-us-east-1"
    key            = "ssr-web.tfstate.thunderchrome-east-1"
    dynamodb_table = "ssr-web-terrform-us-east-1-lock"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_key_pair" "ssrkey" {
  key_name   = "ssr-key"
  public_key = file("../keys/shared_rsa.pub")
}

resource "aws_key_pair" "thckey" {
  key_name   = "thc-key"
  public_key = file("../keys/shared_rsa.pub")
}