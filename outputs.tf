output "master-ips" {
  description = "Map of public to internal IPs of master nodes"
  value = zipmap(hcloud_server.master.*.ipv4_address, hcloud_server_network.master_vpc.*.ip)
}

output "worker-ips" {
  description = "Map of public to internal IPs of worker nodes"
  value = zipmap(hcloud_server.worker.*.ipv4_address, hcloud_server_network.worker_vpc.*.ip)
}