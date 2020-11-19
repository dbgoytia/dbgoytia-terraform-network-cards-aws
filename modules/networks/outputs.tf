output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "SUBNET_ID" {
  value = aws_subnet.subnet_1.id
}

output "SUBNET_AVAILABILITY_ZONE" {
  value = aws_subnet.subnet_1.availability_zone
}

