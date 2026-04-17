terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version ="~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. Create the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "MainVPC"
  }
}

# 2. Create the S3 Bucket with an Implicit Dependency
resource "aws_s3_bucket" "aws_s3_1st_bucket_provider" {
    
   # (aws_vpc.main_vpc.id) creates the implicit dependency
  bucket =  "bucket-linked-to-${aws_vpc.main_vpc.id}"

  tags = {
    Name = "My_Bucket"
    Environment = "Dev"
  }
}