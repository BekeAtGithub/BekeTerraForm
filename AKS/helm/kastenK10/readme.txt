for Python script:
K10 API URL: The K10_API_URL should point to the Kasten K10 API endpoint. This could be a local endpoint if you’re port-forwarding, or the service endpoint if accessible externally.

Authentication: The HEADERS object contains the JWT token or Bearer token to authenticate requests to the Kasten K10 API.

List Policies: The list_policies function fetches available Kasten K10 policies using the /policies API endpoint and prints them.

Trigger Backup: The trigger_backup function triggers a backup for the specified policy using the /policies/{policy_name}/run API endpoint.

List Backup Jobs: The list_backup_jobs function lists the status of all backup jobs using the /jobs API endpoint.

Replace the K10_API_URL and K10_TOKEN placeholders with actual values.

How to Get the Kasten K10 Token:

To get the Kasten K10 token, you can either extract the token from the Kasten service or use basic authentication, depending on your setup.

    Get JWT Token from Kasten K10 (from within your Kubernetes cluster):
        Run the following command to get the token:

        bash

    kubectl get secret -n kasten-io k10-k10 -o jsonpath="{.data.token}" | base64 --decode

Use Port-Forwarding to Access Kasten K10 API:

    Run the following command to port-forward the K10 API:

    bash

kubectl port-forward service/gateway -n kasten-io 8080:8000

Then access the API at http://localhost:8080/v0/api.