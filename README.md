# rsschool-devops-course-tasks
DevOps Course
______________________________________________
## Project Overview

This repository contains Terraform code and GitHub Actions workflows to automate AWS infrastructure deployment
The project includes AWS CLI and Terraform installation, IAM user and role configuration, Terraform state management using S3, and secure authentication via GitHub Actions OIDC

## Features
- AWS CLI v2 and Terraform 1.6+ installation instructions
- Creation of IAM user with necessary permissions and MFA enabled
- AWS CLI configured with IAM user credentials
- Terraform state stored in an S3 bucket
- DynamoDB table for Terraform state locking 
- IAM role for GitHub Actions configured with proper trust policies for OIDC authentication
- GitHub Actions workflows with the following jobs:
    - `terraform-check`
    - `terraform-plan`
    - `terraform-apply`

## Getting Started

### 1. Install AWS CLI and Terraform
- Follow the official guide to install AWS CLI v2:  
  https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

- Install Terraform 1.6 or higher:  
  https://learn.hashicorp.com/tutorials/terraform/install-cli

### 2. Create IAM User and Configure MFA
- Create an IAM user with appropriate permissions 
- Enable MFA on both the new user and the root account
- Generate Access Key ID and Secret Access Key for the IAM user

### 3. Configure AWS CLI
- Run `aws configure` and enter the Access Key ID, Secret Access Key, default region, and output format
- Ensure the AWS CLI is configured to use the IAM user credentials
- Verify the configuration by running `aws sts get-caller-identity`

### 4. Create a bucket fot Terraform states
- Create an S3 bucket using Terraform to store the state file
- Set `prevent_destroy` for the S3 bucket in your Terraform configuration
- Configure the backend to use the created S3 bucket and enable state locking via a DynamoDB table

### 5. Set Up GitHub Repository Secrets
- Create a `.tfvars` file for local variables (don't commit this file to the repository)
- Add the following secrets to your GitHub repository:
    - `ACTIONS_CONDITION`
    - `ACTIONS_ROLE_NAME`
    - `AWS_ACCOUNT_ID`
    - `BUCKET_NAME`
    - `CLIENT_ID_LIST`
    - `IAM_POLICIES`
    - `OIDC_PROVIDER_URL`
    - `THUMBPRINT_LIST`

### 6. Create an IAM role for Github Actions
- Create an IAM role for Github Actions with appropriate permissions (managed via secrets)

### 7. Configure an Identity Provider and Trust policies for Github Actions
- Set up the OIDC identity provider and update the trust policy for the IAM role accordingly

### 8. GitHub Actions Workflows
- Workflows are configured to automatically:
  - Validate Terraform code formatting on merge or push to the main branch
  - Plan Terraform changes on merge or push to the main branch
  - Apply Terraform changes on push to the main branch

## Repository Structure
- / — Terraform configurations
- .github/workflows/ — GitHub Actions workflow definitions

## Contact
For questions, reach out to: anikejoksana@gmail.com



    
    
  