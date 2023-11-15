output "iam_role" {
  value = try(aws_iam_role.github[0], null)
}

output "assume_role_policy" {
  value       = data.aws_iam_policy_document.assume_role.json
  description = "The assume role policy document for the IAM role."
}
