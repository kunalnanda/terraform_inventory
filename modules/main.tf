resource "aws_instance" "ec2_instance_cluster" {
    count                   = var.ec2_count
    ami                     = var.ami_id
    instance_type           = var.ec2_instance_type
    vpc_security_group_ids  = [var.ec2_security_groups]
    iam_instance_profile    = var.ec2_instance_profile
    key_name                = var.ec2_keypair_name
    subnet_id               = lookup(var.ec2_subnet_placements, count.index % length(var.ec2_subnet_placements))
    associate_public_ip_address = "true"
    
    root_block_device {
        encrypted           = "true"
        kms_key_id          = var.ebs_kms_key
    }

    tags = {
        Name = "${var.ec2_tier}-${count.index+1}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo useradd -m -d /home/ansible_user -s /bin/bash ansible_user",
            "sudo mkdir -p /home/ansible_user/.ssh",
            "sudo touch /home/ansible_user/.ssh/authorized_keys",
            "sudo echo '${var.ec2_ansible_user}' > authorized_keys",
            "sudo mv authorized_keys /home/ansible_user/.ssh",
            "sudo chown -R ansible_user:ansible_user /home/ansible_user/.ssh",
            "sudo chmod 700 /home/ansible_user/.ssh",
            "sudo chmod 600 /home/ansible_user/.ssh/authorized_keys",
            "sudo usermod -aG wheel ansible_user",
            "sudo echo 'ansible_user  ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ansible_user"
        ]

        connection {
            type            = "ssh"
            user            = "ec2-user"
            host            = self.public_ip
            private_key     = file("~/.ssh/terraform_keypair")
        }
    }  
}

resource "aws_ebs_volume" "ebs_data" {
    count                   = var.ec2_count
    size                    = var.ebs_size
    availability_zone       = lookup(var.ec2_az_placements, count.index % length(var.ec2_az_placements))
    encrypted               = "true"
    kms_key_id              = var.ebs_kms_key

    tags = {
        Name = "data-volume-${var.ec2_tier}-${count.index+1}"
    }
}

resource "aws_volume_attachment" "ebs_data_attachment" {
    count                   = var.ec2_count
    device_name             = "/dev/sdb"
    volume_id               = element(aws_ebs_volume.ebs_data.*.id, count.index)
    instance_id             = element(aws_instance.ec2_instance_cluster.*.id, count.index)
    force_detach            = true
}