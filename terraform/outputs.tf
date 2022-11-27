output "vpc" {
  value = module.vpc

}



output "ec2" {
  value = module.ec2
}

output "elb" {
  value = module.elb

}


# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.vpc_name.id
# }

# output "vpc_arn" {
#   description = "The ARN of the VPC"
#   value       = aws_vpc.vpc_arn.arn
# }

# output "vpc_cidr_block" {
#   description = "The CIDR block of the VPC"
#   value       = try(aws_vpc.this[0].cidr_block, "")
# }




# output "vpc_owner_id" {
#   description = "The ID of the AWS account that owns the VPC"
#   value       = try(aws_vpc.this[0].owner_id, "")
# }

# output "private_subnets" {
#   description = "List of IDs of private subnets"
#   value       = aws_subnet.private[*].id
# }

# output "private_subnet_arns" {
#   description = "List of ARNs of private subnets"
#   value       = aws_subnet.private[*].arn
# }

# output "private_subnets_cidr_blocks" {
#   description = "List of cidr_blocks of private subnets"
#   value       = compact(aws_subnet.private[*].cidr_block)
# }

# output "public_subnets" {
#   description = "List of IDs of public subnets"
#   value       = aws_subnet.public[*].id
# }

# output "public_subnet_arns" {
#   description = "List of ARNs of public subnets"
#   value       = aws_subnet.public[*].arn
# }

# output "public_subnets_cidr_blocks" {
#   description = "List of cidr_blocks of public subnets"
#   value       = compact(aws_subnet.public[*].cidr_block)
# }


# output "nat_ids" {
#   description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
#   value       = aws_eip.nat[*].id
# }

# output "nat_public_ips" {
#   description = "List of public Elastic IPs created for AWS NAT Gateway"
#   value       = var.reuse_nat_ips ? var.external_nat_ips : aws_eip.nat[*].public_ip
# }


# # VPC flow log
# # output "vpc_flow_log_id" {
# #   description = "The ID of the Flow Log resource"
# #   value       = try(aws_flow_log.this[0].id, "")
# # }

# # output "vpc_flow_log_destination_arn" {
# #   description = "The ARN of the destination for VPC Flow Logs"
# #   value       = local.flow_log_destination_arn
# # }

# # output "vpc_flow_log_destination_type" {
# #   description = "The type of the destination for VPC Flow Logs"
# #   value       = var.flow_log_destination_type
# # }

# # output "vpc_flow_log_cloudwatch_iam_role_arn" {
# #   description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
# #   value       = local.flow_log_iam_role_arn
# # }

# # Static values (arguments)
# output "azs" {
#   description = "A list of availability zones specified as argument to this module"
#   value       = var.azs
# }

# output "name" {
#   description = "The name of the VPC specified as argument to this module"
#   value       = var.name
# }
