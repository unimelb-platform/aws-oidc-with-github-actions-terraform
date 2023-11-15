resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list
}

resource "aws_iam_role" "github" {
  count = var.create_role ? 1 : 0

  name                 = var.iam_role_name
  description          = var.iam_role_description
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = var.max_session_duration
  path                 = var.iam_role_path
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each = toset(var.iam_role_policy_arns)

  role       = aws_iam_role.github[0].id
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline" {
  for_each = var.iam_role_inline_policies

  name   = each.key
  role   = aws_iam_role.github[0].id
  policy = each.value
}
