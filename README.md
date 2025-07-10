# rsschool-devops-course-tasks
DevOps Course

![Terraform CI/CD](https://github.com/oksana-babich/rsschool-devops-course-tasks/actions/workflows/terraform.yaml/badge.svg)
______________________________________________
## Project Overview

This project contains Terraform configuration for creating AWS infrastructure with automated CI/CD pipeline through GitHub Actions.
It also includes the setup and verification of a lightweight Kubernetes cluster (k3s) deployed on EC2 instances, accessible via a bastion host.


## 🏗️ Infrastructure Architecture

The infrastructure includes the following components:

### Network Infrastructure
- **VPC** - isolated virtual network
- **Public Subnets** - for resources with internet access
- **Private Subnets** - for internal resources
- **Internet Gateway** - for internet access
- **NAT Gateway** - for outbound traffic from private subnets
- **Route Tables** - traffic routing

### Compute Resources
- **EC2 Instances** - virtual machines (including: bastion host and k3s control plane and worker nodes)
- **Security Groups** - firewall rules
- **ACL** - additional network security layer

### State Management
- **S3 Bucket** - for storing Terraform state
- **Remote State Backend** - centralized state management

### CI/CD
- **GitHub Actions** - deployment automation
- **OIDC Provider** - secure authentication with AWS
- **IAM Roles** - access management for GitHub Actions

### Kubernetes Cluster with k3s
🚀 Deployment
- **Deployed via EC2 Instances** - using AWS Free Tier
- **Lightweight K3s Distribution** – installed on EC2
- **Access via Bastion Host** – SSH access and kubectl commands
- **Local Access** – configure SSH tunneling to interact from local machine

### ✅ Cluster Verification
- Confirmed cluster with kubectl get nodes on bastion host
- Deployed a test workload with:
```
  kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
```

### 🔐 Security
- SSH access only via Bastion
- Security Groups restrict access to necessary ports (22, 6443, etc.)
- IAM roles limited to required resources only

## 📋 Prerequisites

- AWS account with appropriate permissions
- Terraform >= 1.12.1
- GitHub repository with configured secrets
- SSH key pair for EC2 instances
- kubectl for cluster interaction

## 🔧 GitHub Secrets Configuration

The following secrets need to be configured in GitHub:
```
AWS_ACCOUNT_ID - Your AWS account 
ID BUCKET_NAME - S3 bucket name for Terraform state 
CLIENT_ID_LIST - List of client IDs for OIDC 
THUMBPRINT_LIST - List of thumbprints for OIDC 
ACTIONS_ROLE_NAME - IAM role name for GitHub Actions 
OIDC_PROVIDER_URL - OIDC provider URL 
ACTIONS_CONDITION - OIDC conditions 
IAM_POLICIES - List of IAM policies 
KEY_NAME - EC2 Key Pair name
K3S_TOKEN - Shared secret token used by K3s server and agent nodes for cluster join
```

## 🚀 Deployment

### Automatic Deployment

1. **Push to `main` branch** - triggers full pipeline
2. **Pull Request** - triggers validation and planning

### Manual Deployment
1. Clone this repository
2. Configure your `terraform.tfvars`
3. Run:
```
# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply
```

## 📁 Project Structure
``` 
.
├── .github/
│   └── workflows/
│       └── terraform.yaml          # CI/CD pipeline
├── acl.tf                          # Network ACL configuration
├── ec2.tf                          # EC2 instances (bastion host, k3s nodes)
├── vpc.tf                          # VPC configuration
├── nat_gateway.tf                  # NAT Gateway
├── security_groups.tf              # Security Groups configuration
├── route_table_public_subnets.tf   # Routes for public subnets
├── route_table_private_subnets.tf  # Routes for private subnets
├── github_actions_role.tf          # IAM role for GitHub Actions
├── remote_state_backend.tf         # Backend for Terraform state
├── S3Bucket_Creation_ForRemoteState.tf # S3 bucket for state
├── variables.tf                    # Variables
├── outputs.tf                      # Output values
└── README.md                       # This file
```
## 🔒 Security
- Using OIDC for GitHub Actions authentication with AWS
- Principle of least privilege for IAM roles
- Separation of public and private subnets
- Configured Security Groups and Network ACLs

## 📊 Outputs
After successful deployment, the following output values are available:
- - ID of the created VPC `vpc_id`
- - Availability Zone of public subnet 1 `public_subnet_1_AZ`
- - Availability Zone of public subnet 2 `public_subnet_2_AZ`
- - Availability Zone of private subnet 1 `private_subnet_1_AZ`
- - Availability Zone of private subnet 2 `private_subnet_2_AZ`

## 🔄 CI/CD Pipeline
The pipeline consists of three stages:
1. **Format Check** - validates Terraform code formatting
2. **Plan** - creates execution plan
3. **Apply** - applies changes (only for main branch)

## 🌍 Deployment Region
By default, the infrastructure is deployed in the region (Frankfurt). `eu-central-1`
## 🛠️ Development
Before making changes:
1. Create a new branch
2. Make your changes
3. Run `terraform fmt` for formatting
4. Create a Pull Request

## 📝 Notes
- Terraform state is stored remotely in S3
- All sensitive data is stored in GitHub Secrets
- Infrastructure follows AWS Well-Architected Framework best practices

## 🤝 Support
If you encounter issues:
1. Check GitHub Actions logs
2. Verify secrets configuration
3. Check IAM role permissions
4. Verify SSH and Security Group access

## 🧪 Jenkins Deployment on Minikube
Installing and configuring Jenkins on a local Minikube Kubernetes cluster using Helm. The key steps and deliverables are:
- Install Helm and verify it by deploying/removing the Bitnami Nginx chart
- Prepare Minikube cluster with Persistent Volume support
- Deploy Jenkins in a dedicated jenkins namespace using a custom Helm chart and values file
- Configure Jenkins using Jenkins Configuration as Code (JCasC) to automatically create a "Hello World" freestyle job
- Ensure Jenkins is accessible via web browser
- Verify the Jenkins job runs successfully and logs "Hello world"

### Requirements
- Minikube
- Helm 3.x
- kubectl
- Docker (for Minikube)

### Installation and Verification
Install Helm ([official guide](https://helm.sh/docs/intro/install/))and verify by deploying the Nginx chart:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install test-nginx bitnami/nginx
helm uninstall test-nginx
```
Start Minikube and ensure PV/PVC support:
```bash
minikube start
```
Add Jenkins Helm repository and install Jenkins in its namespace:
```bash
helm repo add jenkins https://charts.jenkins.io
helm repo update
kubectl create namespace jenkins
helm upgrade --install jenkins jenkins/jenkins -n jenkins -f jenkins-values.yaml
```
Access Jenkins UI via browser (e.g., ```minikube service jenkins -n jenkins --url```)

### Configuration Highlights
- Jenkins jobs and settings are managed through JCasC in the Helm chart values file ```jenkins-values.yaml```
- "Hello World" freestyle job created automatically via JCasC configuration

### Verification
- Confirm Jenkins pods are running with ```kubectl get pods -n jenkins```
- Run the "Hello World" job and check logs for correct output


## Contact
For questions, reach out to: anikejoksana@gmail.com



    
    
  