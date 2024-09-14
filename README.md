![image](https://github.com/user-attachments/assets/bc147b24-81f3-44cf-a0b8-497ccdd22a6a)


Description:
This project uses Terraform to provision AWS infrastructure components required for production and staging environments. Each environment includes modules for creating a Virtual Private Cloud (VPC), an Amazon Elastic Kubernetes Service (EKS) cluster, AWS storage solutions (EBS & S3), and security configurations (IAM roles, security groups).


Modules:
1. VPC Module (modules/vpc)
Creates a VPC with public and private subnets.
Configures Internet Gateways, NAT Gateways, Route Tables, and associations for proper traffic routing.

2. EKS Module (modules/eks)
Provisions an EKS cluster with managed node groups for Kubernetes workloads.
Enables multi-AZ deployment and Kubernetes Cluster Autoscaler.

4. Storage Module (modules/storage)
Sets up EBS volumes for persistent storage.
Creates S3 buckets for object storage.

6. Security Module (modules/security)
Configures AWS security groups, IAM roles, and policies.
Implements best practices such as least privilege and secure access control.

Folder Breakdown:

terraform/environments/production/main.tf
This file provisions the infrastructure for the production environment by calling each module.
Adjust environment-specific variables in the variables.tf file.

terraform/environments/staging/main.tf
This file provisions the infrastructure for the staging environment.
It has a similar structure to production but may contain environment-specific values like smaller cluster sizes.

terraform/versions.tf
Defines the minimum required Terraform and provider versions to ensure compatibility.

terraform/variables.tf
Contains variables shared across the environments, such as region, VPC CIDR blocks, cluster name, etc.
Adjust values here for different environments (e.g., staging vs production).

terraform/backend.tf
Configures remote state storage in an S3 bucket to store Terraform's state file.
The backend uses DynamoDB for state locking to prevent concurrent changes.

Setup Instructions:
Step 1: Install Prerequisites
Ensure you have the following installed on your machine:

1]Terraform
2]AWS CLI
3]kubectl
You can install them using:


# Terraform installation
brew install terraform

# AWS CLI installation
brew install awscli

# kubectl installation
brew install kubectl
Step 2: Set up AWS Credentials
Make sure your AWS credentials are configured in your environment by running:


aws configure
Provide your AWS Access Key, Secret Key, Region, and Output Format.

Step 3: Initialize Terraform
Navigate to the root of your project (terraform/environments/production or terraform/environments/staging), then run:


terraform init
This will initialize Terraform and download necessary provider plugins and modules.

Step 4: Plan and Apply Changes
To preview the infrastructure changes, run:

#terraform plan
To apply the changes to your AWS environment, run:


#terraform apply
You will be prompted to confirm the changes by typing yes.

Step 5: Verify the Deployment
After the deployment, you can verify your resources in the AWS console:

1]Check the VPC, subnets, and route tables under VPC.
2]Look for the EKS cluster under EKS.
3]Verify the S3 buckets and EBS volumes in S3 and EC2 sections.
4]Ensure that your security groups and IAM roles are set up correctly.

Step 6: Destroy Infrastructure
When you're done and want to remove all resources, run:


terraform destroy
This will tear down the entire infrastructure.

Important Notes:
1]State Management: The backend.tf file ensures that Terraform uses remote state storage on S3, preventing state loss and allowing multiple team members to collaborate.

2]Variable Customization: You can adjust environment-specific values by modifying the variables.tf file.

3]Security: Make sure to follow best practices for AWS IAM and use the least privilege principle for permissions.


