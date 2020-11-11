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


output "coloqio-frontend-ecr" {
  value = aws_ecr_repository.coloqio_frontend.repository_url
}
