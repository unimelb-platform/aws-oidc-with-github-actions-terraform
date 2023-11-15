

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "1"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
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
