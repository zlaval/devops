output "laura-password" {
  value = aws_iam_user_login_profile.laura.encrypted_password
}