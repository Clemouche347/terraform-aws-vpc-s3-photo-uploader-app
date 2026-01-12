# Photo Uploader - Mini Web App

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-blue?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)](https://aws.amazon.com/)

A simple Flask web application to upload photos to an AWS S3 bucket.  
This version is deployed on an EC2 instance in a **public subnet**, using Terraform for easy provisioning.

## Features

- Upload images from your browser to S3
- List all uploaded files
- Versioned and encrypted S3 bucket
- Secure access via IAM Role
- Public subnet deployment for easy testing and debugging

## Architecture

[Internet]
|
|--- Public Subnet
|
EC2 (Flask Web App)
|
S3 Bucket (versioned, encrypted)

- EC2 has a public IP and security group allows TCP 5000
- Flask app runs on port 5000
- S3 bucket stores uploaded files with versioning and encryption enabled

## Setup Instructions

### 1. Clone the repository

```bash
git clone <repo-url>
cd photo-uploader
```

### 2. Set up Terraform

```bash
terraform init
terraform plan
terraform apply
```

- Ensure you have AWS credentials configured for Terraform
- EC2 will be deployed in a public subnet with a public IP

### 3. Connect to EC2
```
ssh -i /path/to/key.pem ec2-user@<EC2_PUBLIC_IP>
```

### 4. Set environment variable and run Flask
```
export BUCKET_NAME="photo-loader-bucket-eu-west-3"
python3 ~/app.py
```

- Flask runs on 0.0.0.0:5000

- Keep the terminal open to keep Flask running

- Optionally, run in background: nohup python3 ~/app.py &

### 5. Access the app

Open a browser and navigate to:

```
http://<EC2_PUBLIC_IP>:5000
```

- Upload photos and see the list of files

- Files are saved in S3 bucket with versioning enabled


# Notes

Ensure the EC2 IAM Role has permissions for:

s3:PutObject

s3:GetObject

s3:ListBucket
on your bucket

Security Group allows TCP 5000 from your IP (or 0.0.0.0/0 for testing)


# Future Improvements

Use Gunicorn + Nginx for production-ready deployment

Add HTTPS with an SSL certificate

Add authentication for upload access

