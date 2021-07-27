terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.15"
    }
  }

  required_version = ">= 0.14"
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_firewall" "master" {
  name = "${var.scope}-master"

  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "6443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall" "worker" {
  name = "${var.scope}-worker"

  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"]
  }
}

resource "hcloud_server" "master" {
  count = var.masters_count

  name        = "${var.scope}-master-${count.index}"
  server_type = var.hcloud_master_type
  image       = var.hcloud_image
  location    = var.hcloud_location
  ssh_keys    = var.hcloud_ssh_keys
  firewall_ids = [hcloud_firewall.master.id]
}

resource "hcloud_server" "worker" {
  count = var.workers_count

  name        = "${var.scope}-worker-${count.index}"
  server_type = var.hcloud_worker_type
  image       = var.hcloud_image
  location    = var.hcloud_location
  ssh_keys    = var.hcloud_ssh_keys
  firewall_ids = [hcloud_firewall.worker.id]
}

resource "hcloud_network" "vpc" {
  name     = "${var.scope}-cluster-vpc"
  ip_range = "172.16.0.0/12"
}

resource "hcloud_network_subnet" "vpc-subnet" {
  network_id   = hcloud_network.vpc.id
  type         = "server"
  network_zone = "eu-central"
  ip_range     = "172.16.0.0/12"
}

resource "hcloud_server_network" "master_vpc" {
  count = var.masters_count

  server_id  = hcloud_server.master.*.id[count.index]
  network_id = hcloud_network.vpc.id
  ip         = "172.16.0.100"
}

resource "hcloud_server_network" "worker_vpc" {
  count = var.workers_count

  server_id  = hcloud_server.worker.*.id[count.index]
  network_id = hcloud_network.vpc.id
}