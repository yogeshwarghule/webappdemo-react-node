module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # One NAT Gateway per availability zone
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  # Requirement for private hosted zone
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
  }
}
