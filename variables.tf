variable "workers_count" {
  description = "Number of worker nodes"
  type = number
  default = 2
}

variable "masters_count" {
  description = "Number of master nodes"
  type = number
  default = 1
}

variable "hcloud_location" {
  description = "Location for each node"
  type = string
  default = "nbg1"
}

variable "hcloud_image" {
  description = "Linux Image for each node server"
  type = string
  default = "ubuntu-20.04"
}

variable "hcloud_master_type" {
  description = "Type of master node server"
  type = string
  default = "cx11"
}

variable "hcloud_worker_type" {
  description = "Type of worker node servers"
  type = string
  default = "cx11"
}

variable "hcloud_ssh_keys" {
  description = "Name of used ssh keys"
  type = list(string)
}

variable "hcloud_token" {
  description = "API Token of a project"
  type = string
}

variable "scope" {
  description = "Prefix used in name of the every resource"
  type = string
}