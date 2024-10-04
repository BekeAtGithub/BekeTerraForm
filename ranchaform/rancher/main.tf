resource "null_resource" "configure_rancher" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = var.rancher_server_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Rancher installation completed'",
      "sudo docker ps"  # Check if Rancher container is running
    ]
  }
}
