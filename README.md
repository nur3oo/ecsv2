URL Shortener — AWS ECS Fargate
A production-grade URL shortener built on AWS ECS Fargate with zero-downtime deployments, full CI/CD, and security.

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

Architecture
Internet -> WAF -> ALB -> ECS Fargate (Blue/Green)
                               |
                         VPC Endpoints -> ECR, S3, CloudWatch
                               |
                         RDS (Postgres) + ElastiCache (Redis)

## Features

- Cost optimised — VPC Endpoints replace NAT Gateway, cutting data transfer costs
- Zero downtime — Blue/green deployments with health checks and auto-rollback via CodeDeploy
- Secure WAF, least privilege IAM, ACM TLS, GitHub OIDC (no hardcoded secrets)
- Remote state  S3 backend with state locking


## CI/CD
## CI/CD

| Workflow      | Trigger        | What it does                          |
|--------------|---------------|--------------------------------------|
| push.yaml     | Push to main  | Builds and pushes Docker image to ECR |
| plan.yaml     | Pull request  | Runs terraform plan                  |
| apply.yaml    | Push to main  | Applies infrastructure changes       |
| destroy.yaml  | Manual        | Tears down everything                |

GitHub OIDC handles AWS auth, no access keys stored anywhere.

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
