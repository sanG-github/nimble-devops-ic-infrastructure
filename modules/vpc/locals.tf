locals {
  # Namespace for the VPCs, used as the prefix for the VPC names
  namespace = "my-vpc"

  # VPC CIDR
  cidr = "10.0.0.0/16"

  # VPC private subnet CIDRs
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  # VPC public subnet CIDRs
  public_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # VPC NAT gateway flag
  enable_nat_gateway = true

  # VPC single NAT gateway flag
  single_nat_gateway = true

  # VPC one NAT gateway per AZ flag
  one_nat_gateway_per_az = false

  # VPC DNS hostnames flag
  enable_dns_hostnames = true
}
