# tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=bf9a89bf447a9c866dc0d30486aec5a24dbe2631"
  version = "5.1.2"

  name                   = local.namespace
  cidr                   = local.cidr
  azs                    = data.aws_availability_zones.available.names
  private_subnets        = local.private_subnet_cidrs
  public_subnets         = local.public_subnet_cidrs
  enable_nat_gateway     = local.enable_nat_gateway
  single_nat_gateway     = local.single_nat_gateway
  one_nat_gateway_per_az = local.one_nat_gateway_per_az
  enable_dns_hostnames   = local.enable_dns_hostnames
}
