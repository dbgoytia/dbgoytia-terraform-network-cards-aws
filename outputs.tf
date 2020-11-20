output "VPC_ID" {
  value = module.network.VPC_ID
}

output "INSTANCE_IP" {
  value = module.instances.INSTANCE_PUBLIC_IP
}

# Output the public IP's of the worker nodes
output "NODES_PUBLIC_IP" {
    value = {
        for instance in aws_instance.webserver:
            instance.id => instance.public_ip
    }
}