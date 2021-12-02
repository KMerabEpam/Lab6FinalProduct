output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.RDS.id, "")
}
