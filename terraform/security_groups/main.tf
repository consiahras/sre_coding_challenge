# Security Group for EKS Cluster Nodes
resource "aws_security_group" "eks_cluster_sg" {
  name        = var.eks_security_group_name
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Allow traffic within VPC range (adjust CIDR if needed)
    description = "Allow all traffic within VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound internet traffic"
  }

  tags = {
    Name = var.eks_security_group_name
  }
}

# Security Group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = var.lb_security_group_name
  description = "Security group for load balancers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound internet traffic"
  }

  tags = {
    Name = var.lb_security_group_name
  }
}

# Allow Load Balancer to connect to EKS nodes on app port 8080
resource "aws_security_group_rule" "allow_lb_to_eks" {
  description              = "Allow Load Balancer to EKS nodes on port 8080"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  type                     = "ingress"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}
