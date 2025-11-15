output "cluster_endpoint" {
  description = "EKS Cluster endpoint URL"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded CA cert for the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "node_group_name" {
  description = "Name of the node group"
  value       = aws_eks_node_group.default.node_group_name
}

