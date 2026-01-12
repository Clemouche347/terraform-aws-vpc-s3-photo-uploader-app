resource "aws_security_group" "ec2_sg" {
  name        = "terraform-ec2-sg"
  description = "allow HTTP/SSH"
  vpc_id      = aws_vpc.this.id
}

resource "aws_vpc_security_group_ingress_rule" "tcp_22_temporaire_ssh" {
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "${var.my_ip}/32"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-tcp22ssh"
    }
  )
}


resource "aws_vpc_security_group_ingress_rule" "tcp_5000_flask_HTTP" {
  security_group_id = aws_security_group.ec2_sg.id

  from_port   = 5000
  to_port     = 5000
  ip_protocol = "tcp"
  cidr_ipv4   = "${var.my_ip}/32"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-tcp5000flaskhttp"
    }
  )
}


resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.ec2_sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-allow_all"
    }
  )
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}


resource "aws_instance" "web" {
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name = "my-ec2-clef"
  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  
  instance_type        = var.instance_type
  ami                  = data.aws_ami.amazon_linux.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-web_ec2_instance"
    }
  )
}
