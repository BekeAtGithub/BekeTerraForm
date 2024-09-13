#python monitoring script for Linux VM in Azure
#need to run; pip3 install psutil
# returns CPU, Memory, Disk, Network usage and generates into log file- vm_metrics.log
#can use Azure SDK - pip3 install azure-mgmt-monitor

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
    """Get disk usage statistics."""
    disk = psutil.disk_usage('/')
    return {
        'total': disk.total,
        'used': disk.used,
        'free': disk.free,
        'percent': disk.percent
    }

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
    
    # Print metrics (can also write to a file)
    print(json.dumps(metrics, indent=4))

    # You can also append metrics to a log file if needed:
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
