output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR of the VPC"
  value       = module.vpc.vpc_cidr_block
}



output "public_subnets" {
  description = "Public Subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private Subnets"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
    description = "Private subnets cidr block"
    value = module.vpc.private_subnets_cidr_blocks
  
}

output "public_subnets_cidr_blocks" {
    description = "Public subnets cidr block"
    value = module.vpc.public_subnets_cidr_blocks
  
}