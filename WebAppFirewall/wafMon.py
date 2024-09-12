#Need to install - pip install azure-mgmt-network azure-identity azure-mgmt-monitor
import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.monitor import MonitorClient
from datetime import datetime, timedelta

# Set up the Azure credentials and subscription
subscription_id = os.getenv("AZURE_SUBSCRIPTION_ID")
credential = DefaultAzureCredential()

# Initialize Network Management and Monitor Clients
network_client = NetworkManagementClient(credential, subscription_id)
monitor_client = MonitorClient(credential, subscription_id)

# Define resource group and application gateway details
resource_group_name = "myResourceGroup"
application_gateway_name = "myApplicationGateway"

# Function to get WAF diagnostics logs (alerts)
def get_waf_diagnostics_logs(resource_group, application_gateway):
    # Get diagnostic settings for the application gateway
    diag_settings = network_client.application_gateways.get_diagnostics_settings(
        resource_group_name=resource_group,
        application_gateway_name=application_gateway
    )
    
    if diag_settings:
        print("Diagnostic Settings for WAF found.")
        return diag_settings
    else:
        print("No diagnostic settings found for WAF.")
        return None

# Function to get WAF metrics (alerts and blocked requests)
def get_waf_metrics(resource_group, application_gateway):
    # Define time range (last 1 hour)
    time_now = datetime.utcnow()
    time_past = time_now - timedelta(hours=1)
    timespan = f"{time_past}/{time_now}"

    # List available metrics for Application Gateway
    metrics_data = monitor_client.metrics.list(
        resource_uri=f"/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.Network/applicationGateways/{application_gateway}",
        timespan=timespan,
        interval="PT1M",  # One-minute intervals
        metricnames="TotalRequests,BlockedRequests",
        aggregation="Total"
    )

    # Parse and print WAF metrics
    for metric in metrics_data.value:
        print(f"Metric: {metric.name.value}")
        for timeserie in metric.timeseries:
            for data in timeserie.data:
                print(f"Time: {data.time_stamp}, Total: {data.total}")

# Main function to monitor WAF
def monitor_waf():
    # Fetch WAF diagnostic logs (optional)
    waf_logs = get_waf_diagnostics_logs(resource_group_name, application_gateway_name)
    if waf_logs:
        print(f"Diagnostic settings: {waf_logs}")

    # Fetch and monitor WAF metrics (blocked requests, total requests)
    print("Fetching WAF metrics for the past hour...")
    get_waf_metrics(resource_group_name, application_gateway_name)

if __name__ == "__main__":
    monitor_waf()
