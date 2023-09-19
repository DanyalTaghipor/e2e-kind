# End-to-End Automation with Terraform and Ansible for AWS: Kind and Docker Installation

**_This project_** provides an end-to-end automation solution for setting up an AWS environment with Docker and Kind (Kubernetes in Docker) using Terraform and Ansible. The automation sets up the necessary infrastructure on AWS, including EC2 instances, VPCs, and security groups. Once the foundational infrastructure is provisioned, Ansible takes over to install Docker and Kind on the EC2 instance.

## Prerequisites

Before using this project, ensure you have the following tools installed:

| Name      |
|-----------|
| Terraform |
| Ansible   |

Additionally, you should have:

- An active AWS account.
- AWS Access Key and Secret Access Key configured for programmatic access.
- An SSH key pair set up in your AWS account for accessing the EC2 instance.

## Usage

To deploy Docker and Kind on an AWS EC2 instance:

1. Navigate to the `terraform` directory (or the specific directory containing your Terraform configurations).
   
   ```sh
   $ cd terraform/path_to_your_directory
2. Initialize Terraform and apply the configurations:

   ```sh
   $ terraform init
   $ terraform plan
   $ terraform apply
After the infrastructure is set up, Ansible will automatically begin its configuration process, installing Docker and Kind on the EC2 instance.

If you encounter any issues or need further assistance, please open an issue in this repository.