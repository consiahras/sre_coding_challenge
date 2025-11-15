variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to deploy security groups into"
  type        = string
}

variable "eks_security_group_name" {
  description = "EKS Cluster security group name"
  type        = string
  default     = "sre-challenge-eks-sg"
}

variable "lb_security_group_name" {
  description = "Load Balancer security group name"
  type        = string
  default     = "sre-challenge-lb-sg"
}
