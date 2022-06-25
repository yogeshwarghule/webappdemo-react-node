variable "web_server_ami" {
  type    = string
  default = "ami-0d38e3348f242b184"
}

variable "app_server_ami" {
  type    = string
  default = "ami-04fa1e528a9c7bf67"
}

variable "database_server_ami" {
  type    = string
  default = "ami-01a02370342aded44"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "environment" {
    description = "tf-deployment"
    default = "tf-deployment"
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  type = list(any)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type = list(any)
  default = ["10.0.10.0/24"]
}