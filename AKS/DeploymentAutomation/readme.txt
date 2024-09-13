Azure DevOps Pipeline:

    trigger: Automatically triggers the pipeline on pushes to the main branch.
    pool: Defines the virtual machine environment (ubuntu-latest) where the tasks will run.
    variables: Includes key variables such as Terraform version, Azure subscription, resource group, and AKS cluster name.
    steps: This section contains the following:
        Install Terraform: Installs Terraform in the Azure DevOps pipeline environment.
        Initialize Terraform: Runs terraform init to initialize the Terraform backend.
        Plan: Runs terraform plan to review the actions Terraform will perform.
        Apply: Runs terraform apply to deploy the AKS cluster, assuming the Terraform plan is approved.

    ** Important to require secrets to be stored securely. You will need to set up the following secrets:

    Azure DevOps:
        ARM_CLIENT_ID: The Client ID of your Azure Service Principal.
        ARM_CLIENT_SECRET: The Client Secret of your Azure Service Principal.
        AZURE_SUBSCRIPTION: The Azure Subscription ID.

    Add these variables as Pipeline Variables or Secrets in your Azure DevOps pipeline.
