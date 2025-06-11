#Adding OIDC provider for GitHub Actions, trust the GitHub Actions OIDC provider to allow it to assume the role.
resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_provider_url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list
}

#creating an IAM role for GitHub Actions with necessary permissions.
resource "aws_iam_role" "github_actions_role" {
  name = var.github_actions_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = var.github_actions_condition
          }
        }
      }
    ]
  })

  #attaching policies to the role to allow it to perform actions on AWS services.
  tags = {
    Name = var.github_actions_role_name
  }
}

resource "aws_iam_role_policy_attachment" "attach_policies" {
  for_each   = toset(var.iam_policies)
  role       = aws_iam_role.github_actions_role.name
  policy_arn = each.value
}




