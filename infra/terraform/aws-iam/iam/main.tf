resource "aws_iam_group" "accountants" {
  name = "Accountant"
}

data "aws_iam_policy" "readonly" {
  name = "ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "accountants-readonly" {
  group      = aws_iam_group.accountants.name
  policy_arn = data.aws_iam_policy.readonly.arn
}

resource "aws_iam_user" "laura" {
  name = "Laura"
}

resource "aws_iam_user_login_profile" "laura" {
  user                    = aws_iam_user.laura.name
  pgp_key                 = "keybase:${aws_iam_user.laura.name}"
  password_length         = 12
  password_reset_required = true
}

resource "aws_iam_group_membership" "team" {
  name  = "accountant-group-membership"
  users = [
    aws_iam_user.laura.name
  ]
  group = aws_iam_group.accountants.name
}

