#python monitoring script for Windows VM in Azure
#need to run; pip install psutil
# returns CPU, Memory, Disk, Network usage and generates into log file- vm_metrics.log
#can use Azure SDK - pip install azure-mgmt-monitor

import psutil
import time
import json
from datetime import datetime

def get_cpu_usage():
    """Get CPU usage statistics."""
    return psutil.cpu_percent(interval=1)

def get_memory_usage():
    """Get memory usage statistics."""
    memory = psutil.virtual_memory()
    return {
        'total': memory.total,
        'available': memory.available,
        'used': memory.used,
        'free': memory.free,
        'percent': memory.percent
    }

def get_disk_usage():
    """Get disk usage statistics for all drives."""
    disk_usage = {}
    partitions = psutil.disk_partitions()
    for partition in partitions:
        usage = psutil.disk_usage(partition.mountpoint)
        disk_usage[partition.device] = {
            'total': usage.total,
            'used': usage.used,
            'free': usage.free,
            'percent': usage.percent
        }
    return disk_usage

def get_network_stats():
    """Get network I/O statistics."""
    net = psutil.net_io_counters()
    return {
        'bytes_sent': net.bytes_sent,
        'bytes_recv': net.bytes_recv,
        'packets_sent': net.packets_sent,
        'packets_recv': net.packets_recv
    }

def log_metrics():
    """Log system metrics to a file."""
    metrics = {
        'timestamp': datetime.utcnow().isoformat(),
        'cpu_usage_percent': get_cpu_usage(),
        'memory_usage': get_memory_usage(),
        'disk_usage': get_disk_usage(),
        'network_stats': get_network_stats()
    }
    
    # Print metrics to console
    print(json.dumps(metrics, indent=4))

    # Append metrics to a log file
    with open("vm_metrics.log", "a") as logfile:
        logfile.write(json.dumps(metrics) + "\n")

if __name__ == "__main__":
    print("Starting monitoring... Press Ctrl+C to stop.")
    try:
        while True:
            log_metrics()
            time.sleep(10)  # Wait 10 seconds before fetching metrics again
    except KeyboardInterrupt:
        print("Monitoring stopped.")
