output "public-id_of_ec2" {
  value = module.EC2.ec2-public-ip
}
output "vpc-id-output" {
  value = module.VPC.VPC_ID
}