module "vpc" {
  source                  = "./modules/vpc"
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  availability_zone_names = var.availability_zone_names
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  env                     = var.env
  costcenter              = var.costcenter
}

module "elb" {
  source           = "./modules/elb"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  env              = var.env
  costcenter       = var.costcenter
  elb_name         = var.elb_name
  ec2_instance_ids = module.ec2.ec2_instance_ids

}

module "ec2" {
  source = "./modules/ec2"

  ec2_instance_name   = var.ec2_instance_name
  env                 = var.env
  private_subnets     = module.vpc.private_subnets
  costcenter          = var.costcenter
  vpc_id              = module.vpc.vpc_id
  ami_id              = var.ami_id
  ec2_instance_count  = var.ec2_instance_count
  instance_type       = var.instance_type
  elb_sg              = module.elb.elb_sg_id
  user_data_file_path = var.user_data_file_path


}