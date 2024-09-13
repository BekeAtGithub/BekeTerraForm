#need to run; pip install requests
#this script uses k10's REST API to trigger backups

import requests
import json
import sys

# Kasten K10 API endpoint and token
K10_API_URL = "https://<K10-API-ENDPOINT>/v0/api"  # Replace <K10-API-ENDPOINT> with the actual Kasten K10 endpoint
K10_TOKEN = "YOUR_K10_TOKEN"  # Replace with your Kasten K10 JWT or Bearer token

# Headers for authentication
HEADERS = {
    "Authorization": f"Bearer {K10_TOKEN}",
    "Content-Type": "application/json"
}

# Function to list Kasten K10 policies
def list_policies():
    url = f"{K10_API_URL}/policies"
    response = requests.get(url, headers=HEADERS, verify=False)
    if response.status_code == 200:
        policies = response.json().get("items", [])
        print("Policies found:")
        for policy in policies:
            print(f"- {policy['metadata']['name']}")
        return policies
    else:
        print(f"Failed to list policies: {response.status_code}")
        sys.exit(1)

# Function to trigger a backup manually
def trigger_backup(policy_name):
    url = f"{K10_API_URL}/policies/{policy_name}/run"
    response = requests.post(url, headers=HEADERS, verify=False)
    if response.status_code == 202:
        print(f"Backup triggered successfully for policy: {policy_name}")
    else:
        print(f"Failed to trigger backup for policy: {policy_name}. Status code: {response.status_code}")
        sys.exit(1)

# Function to list backup jobs
def list_backup_jobs():
    url = f"{K10_API_URL}/jobs"
    response = requests.get(url, headers=HEADERS, verify=False)
    if response.status_code == 200:
        jobs = response.json().get("items", [])
        print("Backup jobs found:")
        for job in jobs:
            print(f"- {job['metadata']['name']} - Status: {job['status']['state']}")
        return jobs
    else:
        print(f"Failed to list backup jobs: {response.status_code}")
        sys.exit(1)

if __name__ == "__main__":
    print("Fetching available policies...")
    policies = list_policies()

    # Trigger a backup for the first policy (modify logic as per your requirements)
    if policies:
        policy_name = policies[0]['metadata']['name']
        print(f"Triggering backup for policy: {policy_name}")
        trigger_backup(policy_name)

    print("Listing backup jobs...")
    list_backup_jobs()
