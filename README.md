добавь # rsschool-devops-course-tasks
DevOps Course

![Terraform CI/CD](https://github.com/oksana-babich/rsschool-devops-course-tasks/actions/workflows/terraform.yaml/badge.svg)
______________________________________________
## Project Overview

This project contains Terraform configuration for creating AWS infrastructure with automated CI/CD pipeline through GitHub Actions.
It also includes the setup and verification of a lightweight Kubernetes cluster (k3s) deployed on EC2 instances, accessible via a bastion host.
This project is configured for automated build and deployment using Jenkins and Helm.
Monitoring and alerting are implemented using Prometheus, Grafana, and Alertmanager, deployed via Helm.



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
├── flask_app/                      # Flask application code and Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   ├── Dockerfile
    ├── test_app.py                 # Test cases for Flask app
    ├── __init__.py                 # Package initialization
├── helm_charts/                    # Helm chart for Jenkins 
│   ├── flask-app/                  # Helm chart for Flask application
│       └── flask-app/values.yaml
    ├──jenkins/                     # Jenkins Helm chart
│       └── jenkins-values.yaml     # Custom values for Jenkins deployment
├── monitoring/                     # Monitoring stack configuration
│   ├── alert-rules.yaml            # Alert rules for Prometheus
│   ├── contact-points.yaml         # Contact points for Alertmanager
    ├── grafana.ini                 # Grafana configuration file
    ├── values-grafana.yaml         # Values for Grafana Helm chart
    ├── values-prometheus.yaml     # Values for Prometheus Helm chart
├── Jenkinsfile                     # Jenkins pipeline configuration
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

## 🐍 Flask Application Deployment on Minikube with Helm

### Task Objective
- Create a Docker image for a simple Flask application.
- Create a Helm chart to deploy the application on Kubernetes (minikube).
- Deploy the application using Helm.
- Ensure the application is accessible via a web browser.
- Document the setup process and store artifacts in git.

---

### Technologies Used
- Docker (for building the app image)
- Helm (for managing Kubernetes manifests)
- Minikube (local Kubernetes cluster)
- Flask (Python web framework)
---
### Implementation Steps

#### 1. Docker Image Creation
- Used official `python:3.9-slim` base image.
- Installed dependencies from `requirements.txt`.
- Application runs with: ```FLASK_APP=main.py flask run --host=0.0.0.0 --port=8080```
- Built image with:
```bash
docker build -t my-flask-app .
```
- Tested locally by running:
```bash
docker run -p 8080:8080 my-flask-app
```
- Application is accessible at ```http://localhost:8080```

#### 2. Helm Chart Creation
- Created a basic chart using:
```bash
helm create flask-app
```
- Configured Deployment to use my-flask-app image.
- Service set as ClusterIP for internal cluster access.
- Ports and environment variables configured for Flask.

#### 3. Loading Image into Minikube
- Used local Docker image.
- Loaded image into Minikube with:
```bash
minikube image load my-flask-app
```
#### 4. Deploying Application via Helm
- Installed the chart:
```bash
helm install flask-app ./flask-app
```
- Verified service and accessed it:
```bash
minikube service flask-app
```
- Application successfully opened in browser at URL like ```http://127.0.0.1:36171```

##### Testing and Verification
- Container runs successfully locally.
- Application is accessible in Kubernetes via minikube service.
- Pod logs confirm Flask is working correctly.
- Web page loads as expected in the browser.

#### Quick Start Commands
```bash
# Start minikube (if not running)
minikube start

# Build Docker image
docker build -t my-flask-app .

# Load image into minikube
minikube image load my-flask-app

# Install Helm chart
helm install flask-app ./flask-app

# Open service in browser
minikube service flask-app
```

### Jenkins Pipeline
The pipeline automatically executes the following stages:
1. **Checkout** - retrieves code from repository
2. **Build App** - installs Python dependencies
3. **Test App** - runs application tests with pytest
4. **Security Check** - performs security analysis with SonarCloud
5. **Docker Build & Push** - builds and publishes Docker image to Docker Hub
6. **Install Helm** - downloads and installs Helm
7. **Deploy to Kubernetes** - deploys application to minikube using Helm
8. **Verify App** - checks application functionality

#### Prerequisites

- Jenkins with installed plugins: Docker, Kubernetes, Pipeline
- Configured credentials in Jenkins:
    - `github-creds` for GitHub repository access
    - `dockerhub-credentials` for Docker Hub
    - `SONAR_TOKEN` for SonarCloud integration
    - `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID` for notifications
- Kubernetes cluster (minikube)
- Helm 3.x

#### Configuration

Main parameters in `values.yaml`:
- `image.repository` - Docker image repository
- `image.tag` - image tag (set automatically by Jenkins)
- `service.port` - service port (8080)
- `serviceAccount.create` - ServiceAccount creation flag

### Local Development
#### Running the Application
```
pip install -r flask_app/requirements.txt
cd flask_app python main.py
```
#### Docker
```
cd flask_app docker build -t flask-app .
docker run -p 8080:8080 flask-app
```

#### Testing
```
cd flask_app pytest test_app.py
```
#### Helm Deployment
```
helm upgrade --install flask-app ./helm_charts/flask-app
--set image.repository=your-repo/flask-app
--set image.tag=latest
--set serviceAccount.create=false
```
### Monitoring and Debugging
```
kubectl get pods -n jenkins
kubectl get service flask-app -n jenkins
curl [http://flask-app.jenkins.svc.cluster.local:8080/](http://flask-app.jenkins.svc.cluster.local:8080/)
```
### Environment Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `FLASK_APP` | Main application file | `main.py` |
| `BUILD_NUMBER` | Jenkins build number | Set automatically |

### Pipeline Features

- **Automated Triggers**: Polls SCM every minute for changes
- **Multi-container Agents**: Uses Python, Docker, and Jenkins containers
- **Security Scanning**: Integrates with SonarCloud for code quality analysis
- **Docker Registry**: Pushes images to Docker Hub with build number and latest tags
- **Kubernetes Deployment**: Uses Helm for deployment with wait conditions
- **Notifications**: Sends Telegram notifications on success/failure

## 📈 Monitoring: Prometheus, Grafana & Alertmanager
🎯 Objective
Deploy a monitoring stack for the Kubernetes cluster using Prometheus, Grafana, and Alertmanager. Metrics are collected via exporters, visualized in Grafana dashboards, and alerts are sent via email using an SMTP server.

### 🧩 Technologies Used
- Helm – to install Prometheus and Grafana from Bitnami charts
- Prometheus – for metrics collection and storage
- Node Exporter / Kube State Metrics – exporters for system and Kubernetes metrics
- Grafana – for metrics visualization and dashboards
- Alertmanager – for alert processing and routing
- SMTP – to send alert notifications via email

### 🔧 Installation and Configuration
### 📦 Prometheus Installation
Add Helm repository for Prometheus and Grafana:
```bash
 helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
 helm repo add grafana https://grafana.github.io/helm-charts
 helm repo update
```
### 📊 Grafana Configuration
- Prometheus added as a data source
- Custom dashboard created with panels for:
CPU usage,
Memory usage,
Disk space usage
-Dashboard exported to JSON (grafana-dashboard.json)

### 📧 Automation Alertmanager and SMTP Setup  
## Installation and configuration fully managed via Helm and YAML (Infrastructure as Code)
- SMTP server
- Configured via ```grafana.ini```
- Contact Points configured in Grafana (email) ```contact-points.yaml```
- Alert rules added ```alert-rules.yaml``` for:
-- 🔥 High CPU usage
-- 🧠 Low memory availability

## Contact
For questions, reach out to: anikejoksana@gmail.com



    
    
  