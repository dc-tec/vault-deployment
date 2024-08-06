resource "vault_github_auth_backend" "main" {
  organization = var.github_organization
}

resource "vault_github_user" "main" {
  for_each = { for user in var.github_users : user.username => user }

  user     = each.value.username
  policies = each.value.policies
}
