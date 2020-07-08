all:
  vars:
    ansible_user: ansible_user
    ansible_ssh_private_key_file: ~/.ssh/ansible_user
    ansible_connection: ssh
    ansible_become: true
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no'

app_tier:
  hosts:
${app_tier_hosts}

web_tier:
  hosts:
${web_tier_hosts}
