variable "coloqio_backend_db_name" {
  default = ""
}

variable "coloqio_backend_db_username" {
  default = ""
}

variable "coloqio_backend_db_password" {
  default = ""
}

resource "aws_db_instance" "coloqio_backend_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t2.medium"
  name                 = var.coloqio_backend_db_name
  username             = var.coloqio_backend_db_username
  password             = var.coloqio_backend_db_password
  publicly_accessible  = true
}

output "coloqio-backend-db" {
  value = "postgres://${aws_db_instance.coloqio_backend_db.username}:${aws_db_instance.coloqio_backend_db.password}@${aws_db_instance.coloqio_backend_db.endpoint}/${aws_db_instance.coloqio_backend_db.name}"
}

resource "aws_ecr_repository" "coloqio_frontend" {
  name                 = "coloqio-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_coloqio_frontend" {
  repository = aws_ecr_repository.coloqio_frontend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 release images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Keep last 10 staging images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["staging"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 3,
            "description": "Only keep review apps images for 7 days",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 7
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


output "coloqio-frontend-ecr" {
  value = aws_ecr_repository.coloqio_frontend.repository_url
}

resource "aws_ecr_repository" "coloqio_backend" {
  name                 = "coloqio-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_coloqio_backend" {
  repository = aws_ecr_repository.coloqio_backend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 release images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Keep last 10 staging images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["staging"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 3,
            "description": "Only keep review apps images for 7 days",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 7
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

output "coloqio-backend-ecr" {
  value = aws_ecr_repository.coloqio_backend.repository_url
}

resource "kubernetes_storage_class" "eks_storageclass_coloqio" {
  metadata {
    name = "coloqio-storageclass"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Delete"
  allowVolumeExpansion = true
  parameters = {
    type = "gp2"
    encrypted = "true"
  }
}
