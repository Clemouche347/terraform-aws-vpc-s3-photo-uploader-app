resource "aws_security_group" "ec2_sg" {
  name        = "terraform-ec2-sg" 
  description = "allow HTTP/SSH"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "tcp 22 temporaire ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  
  from_port = 22
  to_port   = 22
  ip_protocol  = "tcp"
  cidr_ipv4 = "0.0.0.0/0" 

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-tcp22ssh"
    }
  )
}


resource "aws_vpc_security_group_ingress_rule" "tcp 5000 flask HTTP" {
  security_group_id = aws_security_group.ec2_sg.id
  
  from_port = 5000
  to_port   = 5000
  ip_protocol  = "tcp"
  cidr_ipv4 = "0.0.0.0/0" 

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-tcp5000flaskhttp"
    }
  )
}


resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.ec2_sg.id

  ip_protocol  = "-1"
  cidr_ipv4 = "0.0.0.0/0"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-allow_all"
    }
  )
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
  name = "name"
  values = ["al2023-ami-*x86_64"]
  }

  filter {
  name = "virtualization-type"
  values = ["hvm"]
  }

owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.private.id
  key_name               = "your-keypair-name"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-web_ec2_instance"
    }
  )
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
