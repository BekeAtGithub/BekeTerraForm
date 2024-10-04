provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./vpc"
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

module "compute" {
  source           = "./compute"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  key_name         = var.key_name
  instance_type    = var.instance_type
}

module "rancher" {
  source               = "./rancher"
  rancher_server_ip    = module.compute.rancher_instance_public_ip
  ssh_private_key_path = var.ssh_private_key_path
}
