output "vpc_id" {
    description = "ID for the vpc"
    value = aws_vpc.main.id  
}

output "public_subnet_ids" {
    description = "IDs of the 2 public subnets"
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    description = "Ids of the 2 private subnets"
    value = aws_subnet.private[*].id
}

output "nat_gateway_id" {
    description = "IDs of the nat gateway"
    value = aws_nat_gateway.main.id  
}

output "internet_gateway_id" {
    description = "ID of the internet gateway"
    value = aws_internet_gateway.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the vpc"
  value = aws_vpc.main.cidr_block
}