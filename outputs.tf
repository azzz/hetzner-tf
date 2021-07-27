output "master-public-ip" {
  description = "Public IP of master node"
  value = hcloud_server.master.*.ipv4_address
}

output "worker-public-ip" {
  description = "Public IP of worker node"
  value = hcloud_server.worker.*.ipv4_address
}

