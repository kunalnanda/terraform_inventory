# Main terraform file
provider "aws" {
    region = var.aws_region
}

module "app_tier" {
  source = "./modules"

  ec2_count             = var.app_ec2_count
  ami_id                = var.app_ami_id
  ec2_instance_type     = var.app_ec2_type
  ec2_security_groups   = var.app_security_groups
  ec2_instance_profile  = var.app_instance_profile
  ec2_keypair_name      = var.app_keypair_name
  ec2_subnet_placements = local.subnet_placements
  ec2_az_placements     = local.az_placements
  ec2_tier              = "app-tier"

  ebs_kms_key           = var.ebs_kms_key
  ebs_size              = var.app_ebs_size
  ec2_ansible_user      = var.ansible_user

}

module "web_tier" {
  source = "./modules"

  ec2_count             = var.web_ec2_count
  ami_id                = var.web_ami_id
  ec2_instance_type     = var.web_ec2_type
  ec2_security_groups   = var.web_security_groups
  ec2_instance_profile  = var.web_instance_profile
  ec2_keypair_name      = var.web_keypair_name
  ec2_subnet_placements = local.subnet_placements
  ec2_az_placements     = local.az_placements
  ec2_tier              = "web-tier"

  ebs_kms_key           = var.ebs_kms_key
  ebs_size              = var.web_ebs_size
  ec2_ansible_user      = var.ansible_user
}