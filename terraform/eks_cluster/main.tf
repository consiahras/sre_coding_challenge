# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.26" # Adjust Kubernetes version as needed

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.cluster_security_group_id] # Pass security group from variables or remote state
  }

  # Optional logging or endpoint private access can be added here
  # logging {
  #   cluster_logging {
  #     types = ["api", "audit", "authenticator"]
  #   }
  # }
}

# Managed Node Group
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids     = var.subnet_ids
  instance_types = [var.node_instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_size
    max_size     = var.max_size
  }

  tags = {
    Name = "${var.cluster_name}-node-group"
  }
}
