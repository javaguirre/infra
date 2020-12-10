resource "aws_ecr_repository" "avatars" {
  name                 = "avatars"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "avatars" {
  repository = aws_ecr_repository.avatars.name

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
