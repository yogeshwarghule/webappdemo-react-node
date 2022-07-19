# ---------------------------------------------------------------------------------------------------------------------
# EC2 Config
# ---------------------------------------------------------------------------------------------------------------------
variable "web_server_ami" {
  type    = string
  default = "ami-0fb753eb89a05c955"
}

variable "app_server_ami" {
  type    = string
  default = "ami-0007744bbb2e238da"
}

variable "database_server_ami" {
  type    = string
  default = "ami-01a02370342aded44"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "app_server_private_ip" {
  type    = string
  default = "10.0.1.10"
}

variable "db_server_private_ip" {
  type    = string
  default = "10.0.2.10"
}

# ---------------------------------------------------------------------------------------------------------------------
# VPC Config: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# Currently supports 1 public subnet + 2 private subnets. 
# Will need to amend other files such as ec2.tf to support multi-az options.
# ---------------------------------------------------------------------------------------------------------------------
variable "private_subnets" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.0.101.0/24"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-west-2a"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "my-vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# Route 53 Config: TODO
# ---------------------------------------------------------------------------------------------------------------------
