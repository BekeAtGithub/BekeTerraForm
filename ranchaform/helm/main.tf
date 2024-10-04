provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "bitnami/nginx"
  namespace  = "default"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
