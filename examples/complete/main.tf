provider "aws" {
  region = "ap-southeast-2"
}



module "oidc_with_github_actions" {
  source = "../../"

  github_org = "unimelb-platform"
  github_repositories = [
    "tftest.io",
    "terraform-aws-oidc-with-github-actions",
  ]
  create_role          = true
  iam_role_name        = "Example_OIDC_Role"
  iam_role_description = "Enable GitHub OIDC access"
  max_session_duration = 3600
  iam_role_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  iam_role_inline_policies = {
    "ExampleInlinePolicy" = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:ListAllMyBuckets"
          ]
          Resource = "*"
        }
      ]
    })
  }
  iam_role_path = "/security/"
}
