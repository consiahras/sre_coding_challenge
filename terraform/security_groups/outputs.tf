output "eks_security_group_id" {
  description = "Security group ID for EKS worker nodes"
  value       = aws_security_group.eks_cluster_sg.id
}

output "lb_security_group_id" {
  description = "Security group ID for load balancers"
  value       = aws_security_group.lb_sg.id
}
