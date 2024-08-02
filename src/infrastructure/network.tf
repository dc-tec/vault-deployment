resource "libvirt_network" "vault" {
  name      = var.vault_network
  mode      = "nat"
  domain    = var.vault_domain
  addresses = [var.network_address]

  dns {
    enabled    = true
    local_only = false
  }

  dhcp {
    enabled = true
  }
}
