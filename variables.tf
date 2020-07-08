variable "aws_region" {}
variable "ebs_kms_key" {}
variable "ansible_user" {}
variable "vpc_id" {}
variable "ansible_path" {}
variable "backend_bucket" {}
variable "backend_key" {}
variable "backend_dyn_db" {}

# App tier variables
variable "app_ec2_count" {
    default = 0
}
variable "app_ami_id" {}
variable "app_ec2_name" {}
variable "app_ec2_type" {}
variable "app_instance_profile" {}
variable "app_security_groups" {}
variable "app_keypair_name" {}
variable "app_ebs_size" {}

# Web tier variables
variable "web_ec2_count" {
    default = 0
}
variable "web_ami_id" {}
variable "web_ec2_name" {}
variable "web_ec2_type" {}
variable "web_instance_profile" {}
variable "web_security_groups" {}
variable "web_keypair_name" {}
variable "web_ebs_size" {}