output "rancher_server_url" {
  value       = "https://${var.rancher_server_ip}"
  description = "URL to access the Rancher server"
}
