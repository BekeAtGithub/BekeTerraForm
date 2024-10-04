#ansible-runner very good for python scripts
provider "ansible" {
  host_key_checking = false
}

resource "ansible_host" "rancher_server" {
  inventory_hostname = "rancher-server"
  ansible_user       = "ubuntu"
  connection {
    type        = "ssh"
    private_key = file(var.ssh_private_key_path)
    host        = var.rancher_server_ip
  }
}

resource "ansible_play" "configure_rancher" {
  hosts = [ansible_host.rancher_server.inventory_hostname]
  playbook {
    content = file("${path.module}/playbooks/configure_rancher.yml")
  }
}
