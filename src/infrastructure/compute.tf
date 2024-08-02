resource "libvirt_volume" "vault" {
  for_each = var.vault_nodes

  name             = "each.value.node_name.img"
  base_volume_name = var.base_volume
  format           = "qcow2"
  size             = 50 * 1024 * 1024 * 1024 # 50 GB
}

resource "libvirt_domain" "vault_nodes" {
  for_each = var.vault_nodes

  name     = each.value.node_name
  machine  = "pc-q35-5.1"
  firmware = "/run/libvirt/nix-ovmf/OVMF_CODE.fd"

  vcpu   = 2
  memory = 8 * 1024 # 8 GB

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.vault[each.value.node_name].id
  }

  network_interface {
    network_id     = libvirt_network.vault.id
    addresses      = [each.value.ip_address]
    wait_for_lease = false
  }

  video {
    type = "qxl"
  }

  qemu_agent = true

  lifecycle {
    ignore_changes = [
      nvram,
      disk[0].wwn,
      network_interace[0].addresses
    ]
  }
}

resource "libvirt_volume" "load_balancer" {
  name             = "vault_lb.img"
  base_volume_name = var.base_volume
  format           = "qcow2"
  size             = 40 * 1024 * 1024 * 1024 # 40 GB
}

resource "libvirt_domain" "load_balancer" {
  name     = "vault-lb"
  machine  = "pc-q35-5.1"
  firmware = "/run/libvirt/nix-ovmf/OVMF_CODE.fd"

  vcpu   = 2
  memory = 4 * 1024 # 8 GB

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.load_balancer.id
  }

  network_interface {
    network_id     = libvirt_network.vault.id
    addresses      = [each.value.ip_address]
    wait_for_lease = false
  }

  video {
    type = "qxl"
  }

  qemu_agent = true

  lifecycle {
    ignore_changes = [
      nvram,
      disk[0].wwn,
      network_interace[0].addresses
    ]
  }
}
