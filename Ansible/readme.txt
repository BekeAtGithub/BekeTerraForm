Install Terraform with Chocolatey

Verifies Terraform Installation with the win_shell module that runs the command terraform version - which verifies the terraform run job status
        
Display the Terraform Version:
        The debug task is used to print the installed Terraform version for verification.

To run the playbook use this command:

ansible-playbook -i windows_inventory install_chocolatey_terraform.yml