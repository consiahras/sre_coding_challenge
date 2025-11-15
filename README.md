# Basic Structure

sre_coding_challenge/
│
├── CODEOWNERS  
├── .github/
│ └── workflows/
│ └── ci.yml # workflow to run different pipelines depends the commits
├── app/ # main location for our application
│ ├── src/
│ ├── Dockerfile  
│ └── README.md  
├── k8s/ #k8s configuration
│ ├── deployment.yaml  
│ ├── service.yaml  
│ └── README.md  
├── terraform/ #terraform resources creation
│ ├── main.tf  
│ ├── variables.tf  
│ └── README.md  
├── ansible/ #ansible tasks
│ ├── playbook.yml  
│ ├── inventory.ini  
│ └── README.md  
└── README.md
