module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  subnet_1_cidr  = "10.0.1.0/24"
  subnet_2_cidr = "10.0.2.0/24"
  az1           = "us-east-1a"
  az2           = "us-east-1b"
  vpc_name      = "HR_VPC"
  subnet_1_name = "hr-subnet-1"
  subnet_2_name = "hr-subnet-2"


}

module "sg" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id   # vpc module outputs vpc_id
  ec2_sg_name = "ec2-sg"
  rds_sg_name = "rds-sg"
}

module "ec2" {
   source        = "./modules/ec2"
   ami_id        = "ami-02dfbd4ff395f2a1b"  # Replace with valid AMI
   instance_type = "t2.micro"
   subnet_1_id   = module.vpc.subnet_1_id
   sg_id         = module.sg.ec2_sg_id     # Attach EC2 security group

}

module "rds" {
  source         = "./modules/rds"
  subnet_1_id      = module.vpc.subnet_1_id
  subnet_2_id      = module.vpc.subnet_2_id
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  db_user        = "admin"
  db_password    = "Admin12345"
sg_id            = module.sg.rds_sg_id    # Attach RDS security group
}

module "s3" {
    source = "./modules/s3"
    bucket = "faisal-wertyuisdfghjxcfvgh"
  

}

#module "lambda" {
#    source = "./modules/lambda"
#}