GitHub Actions Workflow:

    on.push: This triggers the workflow whenever there is a push to the main branch.
    jobs: Defines the pipeline steps.
        Checkout the code: Pulls the code from your GitHub repository.
        Set up Terraform: Uses the official hashicorp/setup-terraform action to install Terraform.
        Azure Login: Uses the azure/login GitHub action to authenticate with Azure using credentials stored in GitHub Secrets.
        Terraform Init: Initializes the Terraform configuration.
        Terraform Plan: Runs terraform plan to check for any changes.
        Terraform Apply: Automatically applies the Terraform configuration if the pipeline is running on the main branch.

Setting Up Secrets for GitHub Actions and Azure DevOps

** important to require secrets to be stored securely. You will need to set up the following secrets:

    GitHub Actions:
        AZURE_CREDENTIALS: JSON object containing Azure Service Principal credentials.
        ARM_CLIENT_ID: The Client ID of your Azure Service Principal.
        ARM_CLIENT_SECRET: The Client Secret of your Azure Service Principal.

    You can create and store these as GitHub Secrets in your repository (Settings > Secrets).