terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
  required_version = ">= 1.1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

output "web_server_public_dns" {
    value = aws_instance.web_server.public_dns
}