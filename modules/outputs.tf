output module_fqdn {
    value = aws_instance.ec2_instance_cluster.*.public_dns
}