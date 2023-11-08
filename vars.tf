variable "proxmox_host" {
  default = "10.0.0.204"
}

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+5ymclc5Zq7FxLu6yua9hzZV4nctXaO7eNDun0qE69BenWk5FNP8akf4NaljzG1uxOhjkTWLWjHMCt9EK85CzYwPA874NGLyoNI8/2n9CMS9qLGOZYyAXfwLxQOg+xGUk4oTY3VdTcaBWkaouxH4ymsNFubf7UfVHlqZofi4v5L4sAJgHMOsrlYQhIhNgOzSEL0VbT6NhKx5QE7G9ZT2/LL/vupSFCu7hudqeWTWMRV2A/lgEi3l0dEOZpx3kH2DhXDPfFNaw5eVrok/LYCHCVZeY3eKcAYLYLTDQjLpkQ5GTB6TAt1wo4CEP8n67qEYgX7d0zXDjtRWYBuxgqwCL8VjkjvVPRzNDGCKeqM4Il3mciVmGoiQFEyuPLRThH/zuKfmQE51xALYbVfbGT05LcDtNv0rJcHjQA2hD4Dz86p1Gip4VSWCSBtvFs16PPZnUWv4zE39K4DmK9ARujW5sg41/NkcVxDxLAFAe/cdcGPxmEtXBWbIRxtW18egK9A0= javier@javier-pc"
}

variable "virtual_machines" {
  default = {
    "tf-test-01" = {
      hostname    = "tf-test"
      ip_address  = "10.0.0.106/24"
      gateway     = "10.0.0.1",
      vlan_tag    = 100,
      target_node = "pve4",
      cpu_cores   = 2,
      cpu_sockets = 1,
      memory      = "2048",
      hdd_size    = "20G",
      vm_template = "ubuntu-cloud",
    },
    "tf-test-02" = {
      hostname    = "tf-test2"
      ip_address  = "10.0.0.107/24"
      gateway     = "10.0.0.1",
      vlan_tag    = 100,
      target_node = "pve4",
      cpu_cores   = 2,
      cpu_sockets = 1,
      memory      = "2048",
      hdd_size    = "20G",
      vm_template = "ubuntu-cloud",
    },
  }
}