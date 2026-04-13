# ecsv2
ecsv2/
├── .github/
│   └── workflows/
│       ├── apply.yaml          # Terraform apply 
│       ├── destroy.yaml        # Terraform destroy (1 manual step cleanup)
│       ├── plan.yaml           # Terraform plan 
│       └── push.yaml           # Build & push Docker image to ECR
│
├── app/
│   ├── src/
│   │   ├── main.py             # FastAPI app entrypoint
│   │   ├── db.py               # Database connection & queries
│   │   └── events.py           # App lifecycle events
│   ├── tests/
│   │   ├── test_api.py         # API endpoint tests
│   │   └── test_db.py          # Database layer tests
│   ├── dockerfile              # Production container build
│   ├── docker-compose.yml      # Local development environment
│   └── requirements.txt        # Python dependencies
│
├── infra/
│   ├── main.tf                 # Root module wiring
│   ├── variables.tf            # Root inputs
│   ├── terraform.tfvars        # Local values (do not commit secrets)
│   ├── provider.tf             # AWS provider configuration
│   ├── output.tf               # Root outputs
│   │
│   ├── bootstrap/              # One-time bootstrap (S3 bucket + DynamoDB lock table)
│   ├── backend/                # Remote S3 state backend (state locking enabled)
│   │
│   └── modules/
│       ├── vpc/                # VPC + public/private subnets + VPC endpoints
│       ├── sg/                 # Security groups (ALB / ECS / RDS / Redis rules)
│       ├── iam/                # ECS task & execution roles (least privilege)
│       ├── ecr/                # ECR repository
│       ├── alb/                # ALB + target groups + listeners
│       ├── ecs/                # ECS cluster / service / task definition (Fargate)
│       ├── codedeploy/         # Blue/green deployments + health checks + auto-rollback
│       ├── waf/                # WAF rules (firewall protection)
│       ├── certs/              # TLS certificate (ACM) + DNS validation
│       ├── database/           # PostgreSQL (RDS)
│       └── redis/              # Redis cache (ElastiCache)
│
├── .gitignore
└── README.md
