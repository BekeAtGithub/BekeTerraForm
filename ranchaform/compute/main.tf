resource "aws_instance" "rancher_server" {
  ami                         = "ami-0123456789abcdef0"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "Rancher-Server"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
      host        = self.public_ip
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:latest"
    ]
  }
}
