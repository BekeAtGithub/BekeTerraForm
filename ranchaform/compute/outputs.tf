output "rancher_instance_public_ip" {
  value = aws_instance.rancher_server.public_ip
}
