variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}
variable "bucket_name" {
  description = "Name of the S3 bucket for remote state"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the OIDC provider"
  type        = string
}

variable "client_id_list" {
  description = "List of client IDs for the OIDC provider"
  type        = list(string)
}

variable "thumbprint_list" {
  description = "List of thumbprints for the OIDC provider"
  type        = list(string)
}

variable "github_actions_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
}

variable "github_actions_condition" {
  description = "Condition for the GitHub Actions trust policy"
  type        = string
}

variable "iam_policies" {
  description = "List of IAM policies to attach to the role"
  type        = list(string)
}
variable "key_name" {
  description = "SSH key pair name"
  type = string
}