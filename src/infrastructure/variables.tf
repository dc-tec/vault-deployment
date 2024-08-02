variable "vault_nodes" {
  type = list(object({
    node_name  = string
    ip_address = string
  }))
}

variable "base_volume" {
  type        = string
  description = "The location to the base volume to clone from."
}

variable "vault_network" {
  type = string
}

variable "network_address" {
  type = string
}

variable "vault_domain" {
  type = string
}
