# Terraform Infrastructure Modules for SRE Challenge

This directory contains Terraform configurations split into multiple modules, each managing distinct parts of the AWS infrastructure:

- `networking/`: VPC, subnets, internet gateway, and route tables
- `security_groups/`: Security groups for cluster and load balancers (to be implemented)
- `eks_cluster/`: EKS cluster and worker nodes provisioning (to be implemented)

---

## General Deployment Instructions

Each module is an independent Terraform configuration with its own state and variables.

### Prerequisites

- Terraform installed locally (v1.3 or newer recommended)
- AWS CLI configured with appropriate credentials and permissions
- AWS account and access to create VPCs, subnets, EKS clusters, and related services

---

## Deployment Steps

Deploy each module **separately** in the order below to build the full infrastructure:

### 1. Deploy Networking

```
cd terraform/networking
terraform init
terraform apply -var-file=terraform.tfvars
```

This creates the VPC, public and private subnets, internet gateway, and route tables.

Outputs include VPC ID and subnet IDs, used by other modules.

---

### 2. Deploy Security Groups

```
cd ../security_groups
terraform init
terraform apply -var-file=terraform.tfvars
```

This module creates security groups allowing necessary traffic between nodes and load balancers.

It requires IDs from networking outputs, which can be consumed using `terraform_remote_state`.

---

### 3. Deploy EKS Cluster

```
cd ../eks_cluster
terraform init
terraform apply -var-file=terraform.tfvars
```

Deploys a 4-node EKS cluster using the VPC, subnets, and security groups provided by prior steps.

---

## Variable Configuration

All variable values (CIDRs, region, instance types, node counts, etc.) are specified in each module’s `terraform.tfvars` file.

Edit these files to adjust infrastructure according to your requirements.

---

## Notes

- Each module maintains its own independent Terraform state file (`terraform.tfstate`), so resources and state are isolated.
- For collaboration or production use, we should usea remote backend storage for Terraform state files or manage it via cicd or a tool to manage states.

---

This modular approach promotes clean separation and easier maintenance of infrastructure components.

---
