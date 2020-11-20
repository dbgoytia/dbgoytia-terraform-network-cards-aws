output "VPC_ID" {
  value = module.network.VPC_ID
}

# Output the public IP's of the worker nodes
output "NODES_PUBLIC_IP" {
    value = {
        for instance in module.instances.NODES_IDS:
            instance.id => instance.public_ip
    }
}