variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "rancher-vpc"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Rancher and Kubernetes nodes"
  type        = string
  default     = "t2.medium"
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
  type        = string
}
