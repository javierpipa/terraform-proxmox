
resource "proxmox_vm_qemu" "virtual_machines" {
  for_each = var.virtual_machines

  name        = each.value.hostname
  target_node = each.value.target_node
  clone       = each.value.vm_template
  agent       = 1
  os_type     = "cloud-init"
  cores       = each.value.cpu_cores
  sockets     = each.value.cpu_sockets
  cpu         = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  disk {
    slot     = 0
    size     = each.value.hdd_size
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = each.value.vlan_tag
  }

  # Not sure exactly what this is for. something about 
  # ignoring network changes during the life of the VM.
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  # Cloud-init config
  ipconfig0 = "ip=${each.value.ip_address},gw=${each.value.gateway}"
  sshkeys   = var.ssh_key
}

output "vm_ipv4_addresses" {
  value = {
    for instance in proxmox_vm_qemu.virtual_machines :
    instance.name => instance.default_ipv4_address
  }
}

# resource "proxmox_vm_qemu" "proxmox_vm" {
#   count             = 1
#   name              = "tf-vm-${count.index}"
#   target_node       = "pve4"
# clone             = "debian-cloudinit"
# os_type           = "cloud-init"
#   cores             = 4
#   sockets           = "1"
#   cpu               = "host"
#   memory            = 2048
#   scsihw            = "virtio-scsi-pci"
#   bootdisk          = "scsi0"
# disk {
#     size            = "20G"
#     type            = "scsi"
#     storage         = "data2"


#   }
# network {

#     model           = "virtio"
#     bridge          = "vmbr0"
#   }
# lifecycle {
#     ignore_changes  = [
#       network,
#     ]
#   }
# # Cloud Init Settings
#   ipconfig0 = "ip=10.10.10.15${count.index + 1}/24,gw=10.10.10.1"
# sshkeys = <<EOF
#   ${var.ssh_key}
#   EOF
# }

# resource "proxmox_vm_qemu" "proxmox_vm" {
#     count = 1
#     name= "terra_srv2"
#     desc= "Centos demo server with Terraform"
#     target_node = "pve4"
#     clone             = "debian-cloudinit"

#     os_type           = "cloud-init"
#     full_clone  = true

#     cores       = 2
#     sockets     = "1"
#     cpu         = "host"
#     memory      = 2048

#     lifecycle {
#         ignore_changes  = [
#         network,
#         ]
#     }


#     hastate             = ""

#     # vga {
#     #     type   = "std"
#     #     memory = 4
#     # }

#     # Cloud Init Settings
#     ipconfig0 = "ip=10.0.0.150/24,gw=10.0.0.1"
#     # sshkeys =  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+5ymclc5Zq7FxLu6yua9hzZV4nctXaO7eNDun0qE69BenWk5FNP8akf4NaljzG1uxOhjkTWLWjHMCt9EK85CzYwPA874NGLyoNI8/2n9CMS9qLGOZYyAXfwLxQOg+xGUk4oTY3VdTcaBWkaouxH4ymsNFubf7UfVHlqZofi4v5L4sAJgHMOsrlYQhIhNgOzSEL0VbT6NhKx5QE7G9ZT2/LL/vupSFCu7hudqeWTWMRV2A/lgEi3l0dEOZpx3kH2DhXDPfFNaw5eVrok/LYCHCVZeY3eKcAYLYLTDQjLpkQ5GTB6TAt1wo4CEP8n67qEYgX7d0zXDjtRWYBuxgqwCL8VjkjvVPRzNDGCKeqM4Il3mciVmGoiQFEyuPLRThH/zuKfmQE51xALYbVfbGT05LcDtNv0rJcHjQA2hD4Dz86p1Gip4VSWCSBtvFs16PPZnUWv4zE39K4DmK9ARujW5sg41/NkcVxDxLAFAe/cdcGPxmEtXBWbIRxtW18egK9A0= javier@javier-pc"


#     # agent = 0

#     network {
#         bridge = "vmbr0"
#         model = "virtio"
#     }


#     disk {

#         size            = "32G"
#         type            = "scsi"
#         storage         = "ssd1"


#     }



# }