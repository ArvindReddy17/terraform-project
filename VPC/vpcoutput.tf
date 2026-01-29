output "pub-subnet-id" {
  value = aws_subnet.public01.id
}

output "VPC_ID" {
    value = aws_vpc.vpc.id
}

output "pvt-subnet-id" {
  value = aws_subnet.private01.id
}
