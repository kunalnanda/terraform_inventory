# Generate a list of the app-tier hosts Public DNS names
data "template_file" "ansible-app-tier-hosts" {
    count    = var.app_ec2_count
    template = file("./templates/hostnames.tpl")

    vars = {
        ec2_public_dns = module.app_tier.module_fqdn[count.index]
    }
}

data "template_file" "ansible-web-tier-hosts" {
    count    = var.web_ec2_count
    template = file("./templates/hostnames.tpl")

    vars = {
        ec2_public_dns = module.web_tier.module_fqdn[count.index]
    }
}

# Generate final Ansible inventory file
data "template_file" "inventory-file-template" {
    template = file("./templates/ansible_host.tpl")

    vars = {
        app_tier_hosts = join("\n", data.template_file.ansible-app-tier-hosts.*.rendered)
        web_tier_hosts = join("\n", data.template_file.ansible-web-tier-hosts.*.rendered)
    }
}

resource "local_file" "ansible-inventory" {
    content  = data.template_file.inventory-file-template.rendered
    filename = var.ansible_path
}