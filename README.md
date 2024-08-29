 # terraform-aws-vpc
Terraform module which creates VPC resources on AWS.

# Overview
By default this module will provision new Elastic IPs for the VPC's NAT Gateways. This means that when creating a new VPC, new IPs are allocated, and when that VPC is destroyed those IPs are released. Sometimes it is handy to keep the same IPs even after the VPC is destroyed and re-created. To that end, it is possible to assign existing IPs to the NAT Gateways. This prevents the destruction of the VPC from releasing those IPs, while making it possible that a re-created VPC uses the same IPs.

## Features
If you need private subnets that should have no Internet routing (in the sense of RFC1918 Category 1 subnets), intra_subnets should be specified. An example use case is configuration of AWS Lambda functions within a VPC, where AWS Lambda functions only need to pass traffic to internal resources or VPC endpoints for AWS services.

## Usage 
```
provider "aws" {
  region = "ap-northeast-1"
 
}
module "vpc" {
    source = "./module/vpc"
    
    vpc_config = {
        cidr_block = "10.0.0.0/16"
        name = "my-vpc"
    }

    subnet_config = {
        public_subnet = {
        cidr_block = "10.0.0.0/24"
        az = "ap-northeast-1a"
        #To set the subnet as public, default is private
        public =true
      }
        private_subnet = {
        cidr_block = "10.0.1.0/24"
        az = "ap-northeast-1c"
      }
    }
  
}
```