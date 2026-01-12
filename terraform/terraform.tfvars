aws_region   = "eu-west-3"
project_name = "photo-loader"

vpc_cidr = "10.1.0.0/16"

public_subnet_cidr  = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"

instance_type = "t3.micro"

tags = {
  env   = "dev"
  owner = "cvol"

}

my_ip = "37.67.179.225"
