# TODO ACMs
# Eksctl is in another folder k8s

variable "locker_wp_db_username" {
  default = ""
}

variable "locker_wp_db_name" {
  default = ""
}

variable "locker_wp_db_password" {
  default = ""
}

variable "locker_backend_db_name" {
  default = ""
}

variable "locker_backend_db_username" {
  default = ""
}

variable "locker_backend_db_password" {
  default = ""
}

resource "aws_db_instance" "locker_wp_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = var.locker_wp_db_name
  username             = var.locker_wp_db_username
  password             = var.locker_wp_db_password
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
}

resource "aws_db_instance" "locker_backend_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgresql"
  engine_version       = "12.4"
  instance_class       = "db.t2.medium"
  name                 = var.locker_backend_db_name
  username             = var.locker_backend_db_username
  password             = var.locker_backend_db_password
  parameter_group_name = "default.postgresql12.4"
  publicly_accessible  = true
}

output "locker-wp-db" {
  value = "mysql://${aws_db_instance.locker_wp_db.username}:${aws_db_instance.locker_wp_db.password}@${aws_db_instance.locker_wp_db.endpoint}/${aws_db_instance.locker_wp_db.name}"
}

output "locker-backend-db" {
  value = "mysql://${aws_db_instance.locker_backend_db.username}:${aws_db_instance.locker_backend_db.password}@${aws_db_instance.locker_backend_db.endpoint}/${aws_db_instance.locker_backend_db.name}"
}

resource "aws_ecr_repository" "ecr_locker_wordpress" {
  name                 = "locker-wordpress"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_locker_frontend" {
  name                 = "locker-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_locker_admin" {
  name                 = "locker-admin"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_locker_backend" {
  name                 = "locker-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_locker_wordpress" {
  repository = aws_ecr_repository.ecr_locker_wordpress.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


resource "aws_ecr_lifecycle_policy" "ecr_locker_frontend" {
  repository = aws_ecr_repository.ecr_locker_frontend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


resource "aws_ecr_lifecycle_policy" "ecr_locker_admin" {
  repository = aws_ecr_repository.ecr_locker_admin.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "ecr_locker_backend" {
  repository = aws_ecr_repository.ecr_locker_backend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
