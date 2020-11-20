output "VPC_ID" {
  value = module.network.VPC_ID
}

# Output the public IP's of the worker nodes
output "NODES_PUBLIC_IPS" {
    value = module.instances.NODES_PUBLIC_IPS
}