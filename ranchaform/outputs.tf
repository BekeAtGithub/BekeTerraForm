output "rancher_server_ip" {
  value = module.compute.rancher_instance_public_ip
  description = "Public IP address of the Rancher server"
}
