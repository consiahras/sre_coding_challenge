# Directory Structure

```
sre_coding_challenge git:(main) tree
.
├── ansible
│   ├── ansible.cfg
│   ├── inventory
│   │   └── hosts
│   ├── playbooks
│   │   ├── apache.yml
│   │   ├── mariadb.yml
│   │   └── site.yml
│   ├── README.md
│   └── roles
│       ├── apache
│       │   ├── files
│       │   │   └── index.html
│       │   └── tasks
│       │       └── main.yml
│       ├── common
│       │   └── tasks
│       │       └── main.yml
│       └── mariadb
│           └── tasks
│               └── main.yml
├── app
│   ├── Dockerfile
│   ├── README.md
│   ├── requirements.txt
│   └── src
│       └── app.py
├── CODEOWNERS
├── k8s
│   ├── namespace.yaml
│   ├── nginx-configmap.yaml
│   ├── nginx-deployment.yaml
│   ├── nginx-service.yaml
│   ├── README.md
│   ├── simple-web-app-deployment.yaml
│   ├── simple-web-app-hpa.yaml
│   └── simple-web-app-service.yaml
├── README.md
└── terraform
    ├── eks_cluster
    │   ├── iam.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── terraform.tfvars
    │   └── variables.tf
    ├── networking
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── terraform.tfvars
    │   └── variables.tf
    ├── README.md
    └── security_groups
        ├── main.tf
        ├── outputs.tf
        ├── providers.tf
        ├── terraform.tfvars
        └── variables.tf

```

# SRE Coding Challenge Project Structure

This project contains multiple components organizing infrastructure, Kubernetes manifests, application code, and Ansible automation.

---

## Directory Overview with File Descriptions

### ansible/

- `ansible.cfg` - Basic Ansible configuration including inventory file path and SSH settings.
- `inventory/hosts` - Static IP inventory grouping target Ubuntu and RedHat Linux servers.
- `playbooks/`
  - `site.yml` - Main playbook orchestrating common setup, Apache deployment on Ubuntu, and MariaDB deployment on RedHat.
  - `apache.yml` - Playbook focusing on Apache installation and config for Ubuntu servers.
  - `mariadb.yml` - Playbook handling MariaDB installation on RedHat servers.
- `roles/` - Reusable roles for task organization:
  - `common` - Tasks for updating package repos and upgrading packages on all hosts.
  - `apache` - Tasks and files related to Apache webserver installation/configuration.
  - `mariadb` - Tasks responsible for MariaDB installation and service management.

### app/

- `Dockerfile` - Container image build instructions for the sample app.
- `README.md` - Documentation related to the app component.
- `requirements.txt` - Python dependencies for the app.
- `src/app.py` - The Flask Python web application source code.

### k8s/

- Contains Kubernetes manifests for namespaces, deployments, services, configmaps, and horizontal pod autoscalers.
- `README.md` - Instructions on how to deploy the Kubernetes resources locally or on a cluster.

### terraform/

- Modular Terraform infrastructure-as-code directory split into submodules:
  - `networking/`
    - `providers.tf` - AWS provider setup for networking resources.
    - `variables.tf` - Variables declarations like VPC CIDR and subnet CIDRs.
    - `main.tf` - Creates VPC, subnets, internet gateway, and routing.
    - `outputs.tf` - Outputs VPC and subnet IDs for cross-module use.
    - `terraform.tfvars` - Concrete values for the networking variables.
  - `security_groups/`
    - `providers.tf` - AWS provider setup for security groups.
    - `variables.tf` - Variables including VPC ID and security group names.
    - `main.tf` - Defines security groups for EKS nodes and load balancers.
    - `outputs.tf` - Outputs security group IDs.
    - `terraform.tfvars` - Concrete values including reference to VPC ID.
  - `eks_cluster/`
    - `providers.tf` - AWS provider setup for the EKS cluster module.
    - `variables.tf` - Variables for cluster name, subnet IDs, node sizes, security group IDs etc.
    - `main.tf` - EKS cluster and managed node groups creation referencing IAM roles and network resources.
    - `iam.tf` - IAM roles and policies specifically for the EKS cluster and nodes.
    - `outputs.tf` - Cluster endpoint and node group outputs.
    - `terraform.tfvars` - Concrete values including subnet IDs, security groups, and names.
  - `README.md` - Instructions and guidelines on how to deploy the Terraform infrastructure modules.

### Root files

- `README.md` - This file contains an overview and points to README files in each subdirectory explaining how to run each task.
- `CODEOWNERS` - GitHub file specifying code ownership rules.

---

## Basic Usage Instructions

Please refer to the README.md files inside each major directory (`ansible/`, `k8s/`, `terraform/`) for detailed instructions on how to run the playbooks, deploy Kubernetes manifests, and provision infrastructure respectively.

The modular design allows you to work independently on infrastructure, configuration management, and application deployment with clear separation of concerns.

---

Feel free to ask for help on any specific module or file for further customization or automation.
