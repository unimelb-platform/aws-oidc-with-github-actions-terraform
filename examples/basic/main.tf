provider "aws" {
  region = "ap-southeast-2"
}

module "oidc_with_github_actions" {
  source = "../../"

  github_org = "unimelb-platform"
  github_repositories = [
    "terraform-aws-oidc-with-github-actions"
  ]
}
