variable "github_organization" {
  type        = string
  description = "The GitHub organization to use for authentication"
}

variable "github_users" {
  type = list(object({
    username = string
    policies = list(string)
  }))

  description = "A list of GitHub users to add to Vault"
}
