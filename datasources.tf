

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "1"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.create_provider ? aws_iam_openid_connect_provider.github[0].arn : data.aws_iam_openid_connect_provider.github["github"].arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        for repo in var.github_repositories : "repo:${var.github_org}/${repo}:*"
      ]
    }

  }
}

data "aws_iam_openid_connect_provider" "github" {
  for_each = var.create_provider ? toset([]) : toset(["github"])
  url = var.oidc_url
}