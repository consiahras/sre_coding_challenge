aws_region                = "us-east-1"
cluster_name              = "sre-challenge-eks"
vpc_id                    = "<VPC_ID_HERE>"
subnet_ids                = ["<SUBNET_ID_1>", "<SUBNET_ID_2>"] # Fill with your subnet IDs
desired_capacity          = 4
min_size                  = 2
max_size                  = 4
cluster_security_group_id = "<your_cluster_sg_id_here>"
