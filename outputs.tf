output "VPC_ID" {
  value = module.network.VPC_ID
}

# Output the public IP's of the worker nodes
output "NODES_PUBLIC_IPS" {
    value = {
        for instance in module.instances.NODES_PUBLIC_IPS:
            instance.id => instance.public_ip
    }
}