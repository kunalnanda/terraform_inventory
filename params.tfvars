aws_region      = ""
vpc_id          = ""
ebs_kms_key     = ""
ansible_user    = ""
ansible_path    = "ansible_inventory.yaml"
backend_bucket  = ""
backend_key     = "terraform.tfstate"
backend_dyn_db  = "terraform-state-lock"

# --------------------------
# --- App tier variables ---
# --------------------------
app_ec2_count        = 0
app_ami_id           = ""
app_ec2_type         = ""
app_ec2_name         = "app-tier"
app_instance_profile = ""
app_security_groups  = ""
app_keypair_name     = ""
app_ebs_size         = "30"
# --------------------------


# --------------------------
# --- Web tier variables ---
# --------------------------
web_ec2_count        = 0
web_ami_id           = ""
web_ec2_type         = ""
web_ec2_name         = ""
web_instance_profile = ""
web_security_groups  = ""
web_keypair_name     = ""
web_ebs_size         = "30"
# --------------------------