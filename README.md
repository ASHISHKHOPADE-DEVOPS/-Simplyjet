AWS Infrastructure and Kubernetes Deployment

Overview
This project automates the deployment of an AWS infrastructure using Terraform and Kubernetes workloads using Helm. It provisions the necessary cloud resources like VPC, EKS cluster, and networking, while deploying applications such as Next.js, React Dashboard, PostgreSQL, and Redis onto the EKS cluster.

Prerequisites
Before you begin, ensure the following tools are installed:

1]Terraform: Install Terraform
2]AWS CLI: Install AWS CLI and configure it using aws configure
3]kubectl: Install kubectl
4]Helm: Install Helm
Ensure you have the necessary permissions for provisioning AWS resources (IAM user/role) and access to an AWS account.

Project Structure

![image](https://github.com/user-attachments/assets/b82637b7-4cba-43ad-9e41-557b243d2259)




1. Terraform Setup
Step 1: Initialize Terraform
Navigate to the appropriate environment directory (production or staging):

cd terraform/environments/production
Initialize the Terraform workspace to install the required provider plugins:
terraform init

Step 2: Review Terraform Plan
To ensure everything is set up correctly, review the execution plan:
terraform plan

Step 3: Apply Terraform Configuration
Once you confirm the changes, you can apply the Terraform configuration to provision your resources:
terraform apply


This will create:

1]VPC: Virtual Private Cloud for secure networking.
2]EKS: Kubernetes cluster to host your workloads.
3]Subnets: Public and private subnets within the VPC.


Step 4: Configure kubectl to Access EKS
After Terraform completes, configure kubectl to manage your EKS cluster:
aws eks --region <region> update-kubeconfig --name <cluster_name>
This command ensures your local kubectl is configured to interact with the newly created EKS cluster.

2. Helm Setup
Step 1: Verify Kubernetes Cluster
Check if the EKS cluster is accessible by running:
kubectl get nodes
You should see a list of worker nodes provisioned by Terraform.

Step 2: Deploy Helm Charts
1]Next.js Website: Deploy the Next.js website using its Helm chart.
helm install nextjs-website helm/charts/nextjs-website

2]React Dashboard: Deploy the React-based dashboard.
helm install react-dashboard helm/charts/react-dashboard

3]Next.js API: Deploy the Next.js API service.
helm install nextjs-api helm/charts/nextjs-api

4]PostgreSQL Database: Deploy PostgreSQL database.
helm install postgresql helm/charts/postgresql

5]Redis: Deploy Redis for caching.
helm install redis helm/charts/redis

Step 3: Verify Deployments
After each Helm install, verify that the pods are running:
kubectl get pods
You should see the pods for each deployed service.

Step 4: Access Services
Services can be accessed via the LoadBalancer or Ingress configuration, depending on your Helm chart values. You can retrieve the service information using:
kubectl get services
This will provide the public IP or DNS of the LoadBalancer where you can access your application.

3. Customizing Helm and Terraform
Customizing Terraform
1]Each module (VPC, EKS) has customizable variables. Modify the variables by editing the variables.tf files in terraform/modules/vpc or terraform/modules/eks.
2]Set environment-specific variables in terraform.tfvars located in each environment folder (production or staging).


Customizing Helm
Each Helm chart has a values.yaml file that can be modified to customize resources like replica counts, image versions, environment variables, etc.
To upgrade or redeploy with updated values, use:
helm upgrade <release_name> helm/charts/<chart_name> -f helm/charts/<chart_name>/values.yaml

4. Destroying Resources
If you need to clean up and destroy all the provisioned infrastructure, you can do so by running:
terraform destroy


5. Conclusion
This setup provides a scalable and flexible way to provision AWS infrastructure and deploy applications using Kubernetes. The Terraform and Helm combination ensures that you can manage both infrastructure and application deployment with minimal manual intervention.

