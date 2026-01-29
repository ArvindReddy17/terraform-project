module "VPC" {
  source = "./VPC"
}

module "EC2" {
  source        = "./EC2"
  VPC_ID        = module.VPC.VPC_ID
  public_subnet = module.VPC.pub-subnet-id
}

module "S3" {
  source = "./S3"
}