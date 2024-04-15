provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
      encrypt = false
      bucket = "apispocc-team1-bucket-demo"
      dynamodb_table = "Apispocc-team1-db-table"
      key = "path/path/terraform-tfstate-all"
      region = "us-east-1"
  }
}

module "vpc"{
# source = "./modules/vpc"
vpc_cidr_block = "10.0.0.0/16"
name = "Apispocc-vpc"
}

module "subnet"{
source = "./modules/subnet"
vpc_id = module.vpc.vpc_id
subnet_cidr_block_public = ["10.0.1.0/24","10.0.2.0/24"]
subnet_cidr_block_private = ["10.0.3.0/24","10.0.4.0/24"]
subnet_name = "Apispocc-subnet"
}

module "ec2"{
# source = "./modules/ec2"
vpc_id = vpc.vpc_id


/* public-subnet-tf-1= module.subnet.public-subnet-tf-1
public-subnet-tf-2 = module.subnet.public-subnet-tf-2
private-subnet-tf-1 = module.subnet.private-subnet-tf-1
private-subnet-tf-2 = module.subnet.private-subnet-tf-2 */

public-subnets-tf = module.subnet.public-subnets-tf

# private-subnet-tf = module.vpc.Apispocc-private-subnet-tf
# public-subnet-tf = module.vpc.Apispocc-public-subnet-tf 
ami_id = "ami-053b0d53c279acc90"
instance_type = "t2.micro"
ec2_name = "Apispocc-ec2"
}

module "s3"{
source = "./modules/s3"
bucket_name = "apispocc-team1-bucket-demo1"
acl_value = "private"
}
