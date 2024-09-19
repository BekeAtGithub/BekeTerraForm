#This primary file defines the gateway with the Web App Firewall component 
resource "azurerm_application_gateway" "example" {
  name                = "myApplicationGateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    name     = "WAF_v2"        # Use WAF_v2 for Web Application Firewall version 2 
    tier     = "WAF_v2"        # WAF tier for Web Application Firewall
    capacity = 2               # Define the instance capacity (e.g., 2 instances)
  }

  gateway_ip_configuration {
    name      = "myGatewayIpConfig"
    subnet_id = azurerm_subnet.example.id    # Reference the subnet where the App Gateway resides
  }

  frontend_ip_configuration {
    name                 = "myFrontendIpConfig"
    public_ip_address_id = azurerm_public_ip.example.id  # Attach the public IP to the frontend
  }

  frontend_port {
    name = "httpPort"     # Port for HTTP traffic (Optional if only HTTPS is required)
    port = 80
  }

  frontend_port {
    name = "httpsPort"    # Port for HTTPS traffic
    port = 443
  }

  backend_address_pool {
    name = "myBackendAddressPool"   # The backend pool for services to route traffic to
  }

  http_settings {
    name                  = "myHttpSettings"
    cookie_based_affinity  = "Disabled"   # No sticky sessions by default
    port                  = 80           # Backend port (adjust as necessary)
    protocol              = "Http"       # Protocol for backend communication
    request_timeout       = 20           # Set request timeout (in seconds)
  }

  ssl_certificate {
    name     = "mySSLCertificate"      # Define SSL certificate for HTTPS traffic
    data     = filebase64("${path.module}/certificates/mycert.pfx") # Path to your SSL cert
    password = "myPassword"            # Password for the PFX file
  }

  http_listener {
    name                           = "myHttpListener"
    frontend_ip_configuration_name = "myFrontendIpConfig"   # Use the frontend IP configuration
    frontend_port_name             = "httpsPort"            # HTTPS listener
    protocol                       = "Https"               # Use HTTPS
    ssl_certificate_name           = "mySSLCertificate"     # Use SSL for HTTPS traffic
  }

  request_routing_rule {
    name                       = "myRoutingRule"
    rule_type                   = "Basic"   # Basic routing rule type
    http_listener_name          = "myHttpListener"
    backend_address_pool_name   = "myBackendAddressPool"
    backend_http_settings_name  = "myHttpSettings"
  }

  waf_configuration {
    enabled          = true               # Enable the Web Application Firewall
    firewall_mode    = "Prevention"       # Set to "Prevention" to block attacks, or "Detection" for logging only
    rule_set_type    = "OWASP"            # Use OWASP Core Rule Set (CRS)
    rule_set_version = "3.2"              # Define the OWASP version (e.g., 3.2)
  }

  tags = {
    environment = "production"           # Add tags for better management
  }
}
