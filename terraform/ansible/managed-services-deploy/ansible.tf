
resource "local_sensitive_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/inventory.yaml.tmpl",
    { bastion_hosts          = var.bastion_hosts,
      bastion_hosts_var_maps = var.bastion_hosts_var_maps,
      bastion_hosts_yaml_maps = merge(var.bastion_hosts_yaml_maps, local.ssh_private_key_file_map)}

  )
  filename        = "${local.ansible_output_dir}/inventory"
  file_permission = "0600"
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command     = <<-EOT
          ansible-galaxy collection install ${var.ansible_collection_url},${var.ansible_collection_tag}
          ansible-playbook mojaloop.iac.${var.ansible_playbook_name} -i ${local_sensitive_file.ansible_inventory.filename}
    EOT
    working_dir = path.module
  }
  triggers = {
    inventory_file_sha_hex = local_sensitive_file.ansible_inventory.id
    ansible_collection_tag = var.ansible_collection_tag
  }
  depends_on = [
    local_sensitive_file.ansible_inventory
  ]
}

resource "local_sensitive_file" "ec2_ssh_key" {
  content         = var.ansible_bastion_key
  filename        = "${local.ansible_output_dir}/sshkey"
  file_permission = "0600"
}

locals {
  jumphostmap = {
    ansible_ssh_common_args = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -W %h:%p -i ${local_sensitive_file.ec2_ssh_key.filename} -o StrictHostKeyChecking=no -q ${var.ansible_bastion_os_username}@${var.ansible_bastion_public_ip}\""
  }
  ansible_output_dir = "${var.ansible_base_output_dir}/managed-services-deploy"
  ssh_private_key_file_map = {
    ansible_ssh_private_key_file = local_sensitive_file.ec2_ssh_key.filename
  }
}
