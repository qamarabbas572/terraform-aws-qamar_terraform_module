#VPC
output "vpc_id" {
  value = aws_vpc.main.id 
}


#subnet details
output "public_subnet" {
  value = module.public_subnet_output
}
output "private_subnet" {
  value = module.private_subnet_output
}