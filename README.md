## ECS URL Shortener Project
A URL shortener that converts long URLs into short, shareable links that redirect to the original destination.

- Dockerised **URL shortener API** using multi stage builds with images stored in **ECR**
- Deployed on **ECS Fargate** behind an **Application Load Balancer ALB** with HTTP and HTTPS and health checks
- Blue and green deployments using **CodeDeploy** for zero downtime releases and safe traffic shifting
- **AWS WAF** attached to ALB with managed rules and rate limiting for protection against common web exploits
- Fully private networking with no NAT Gateway using **VPC Endpoints** for ECR S3 and CloudWatch
- **RDS PostgreSQL** for persistent storage of shortened URLs and metadata
- **ACM TLS certificates** with **Cloudflare DNS** using DNS validation for HTTPS
- Modular **Terraform infrastructure** with remote S3 backend and state locking enabled
- **GitHub Actions and OIDC** for CI CD with no long lived AWS credentials

Project Structure

```text
ecsv2/
├── .github/
│   └── workflows/
│       ├── apply.yaml          # Terraform apply (on work_dispatch)
│       ├── destroy.yaml        # Terraform destroy (1 step destroy)
│       ├── plan.yaml           # Terraform plan (on work_dispatch)
│       └── push.yaml           # Build & push to ECR
│
├── app/
│   ├── src/
│   │   ├── main.py             # FastAPI entrypoint
│   │   ├── db.py               # Database queries
│   │   └── events.py           # App lifecycle events
│   ├── tests/
│   │   ├── test_api.py         # API tests
│   │   └── test_db.py          # Database tests
│   ├── dockerfile
│   ├── docker-compose.yml
│   └── requirements.txt
│
├── infra/
│   ├── main.tf
│   ├── bootstrap/              # S3 bucket + state locking
│   ├── backend/                # Remote state config
│   └── modules/
│       ├── vpc/                # VPC + subnets + VPC endpoints
│       ├── sg/                 # Security groups
│       ├── iam/                # Least privilege roles
│       ├── ecr/                # Container registry
│       ├── alb/                # Load balancer (80/443)
│       ├── ecs/                # Fargate cluster + service
│       ├── codedeploy/         # Blue/green + auto-rollback
│       ├── waf/                # Firewall rules
│       ├── certs/              # ACM + DNS validation
│       ├── database/           # PostgreSQL (RDS)
│       └── redis/              # ElastiCache
└── README.md

```

## Architecture Diagram
<img width="1399" height="972" alt="Untitled Diagram drawio (1)" src="https://github.com/user-attachments/assets/3dd997e9-c630-4e0d-8492-b4f164eb1499" />




## Features

- Cost optimised - VPC Endpoints replace NAT Gateway, cutting data transfer costs
- Zero downtime - Blue/green deployments with health checks and auto-rollback via CodeDeploy
- Secure WAF, least privilege IAM, ACM TLS, GitHub OIDC (no hardcoded secrets)
- Remote state - S3 backend with state locking

## Why I designed it this way?

## ECS

- Runs containers without managing servers, reducing operational overhead
- Integrates natively with ALB, CodeDeploy and CloudWatch for routing, deployments and monitoring

## VPC Endpoints

- Keeps traffic between ECS and AWS services (ECR, CloudWatch) private within the VPC, avoiding the public internet
- Reduces data transfer costs by removing the need to route through a NAT Gateway
- Improves security by limiting the attack surface of your containers

## S3 for Terraform State with Native State Locking
- Stores Terraform state remotely so the whole team works from a single source of truth
- Native S3 state locking prevents concurrent applies from corrupting the state file, without needing a DynamoDB table
- `prevent_destroy` lifecycle rule protects the state bucket from accidental deletion

## WAF
- Protects the ALB from common web exploits such as SQL injection and XSS attacks
- Allows IP-based rate limiting to mitigate DDoS and brute force attempts
- Sits in front of the ALB so malicious traffic is blocked before it ever reaches the application


## CI/CD

| Workflow      | Trigger        | What it does                          |
|--------------|---------------|--------------------------------------|
| push.yaml     | Workflow_dispatch  | Builds and pushes Docker image to ECR |
| plan.yaml     | Workflow_dispatch | Runs terraform plan                  |
| apply.yaml    | Workflow_dispatch  | Applies infrastructure changes       |
| destroy.yaml  | Workflow_dispatch| Tears down everything                |

GitHub OIDC handles AWS auth, no access keys sthored anywhere.

I chose Workflow dispatch because it eliminates accidental destroys and applies of infrastructure reducing costs for users.

## Tech Stack

| Layer        | Tech                         |
|-------------|------------------------------|
| Compute     | ECS Fargate                  |
| App         | Python + FastAPI             |
| Database    | PostgreSQL (RDS)             |
| Cache       | Redis (ElastiCache)          |
| Deployments | CodeDeploy (blue/green)      |
| Firewall    | WAF                          |
| IaC         | Terraform                    |
| CI/CD       | GitHub Actions + OIDC        |

## Pipeline Screenshots for Build/Push, Tf apply, Tf plan and Tf Destroy

## Build and Push

##<img width="1852" height="929" alt="Screenshot 2026-04-14 183859" src="https://github.com/user-attachments/assets/a7713dcb-171d-4027-bb02-1fe8da9c79c5" />

## Terraform Plan

##<img width="1886" height="1027" alt="Screenshot 2026-04-15 231436" src="https://github.com/user-attachments/assets/a8b771f8-561c-485b-858f-f51ad8b2e95d" />

## Terraform Apply
<img width="1883" height="1012" alt="Screenshot 2026-04-16 194544" src="https://github.com/user-attachments/assets/6721cbe0-6834-46fd-8849-b7a938e7bd84" />

#Terraform Destroy
<img width="1859" height="884" alt="Screenshot 2026-04-17 093611" src="https://github.com/user-attachments/assets/8b5f8a64-8839-42b7-a697-35d8be45863c" />




## What I Would Do Differently

- Set up a multi-environment setup (dev, staging, prod) with separate Terraform workspaces or state files rather than a single environment

- Implement stricter WAF rules and enable AWS Shield for more comprehensive DDoS protection


