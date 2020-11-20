output "VPC_ID" {
  value = module.network.VPC_ID
}

output "INSTANCE_IP" {
  value = module.instances.INSTANCE_PUBLIC_IP
}