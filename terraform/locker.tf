variable "locker_wp_db_username" {
  default = ""
}

variable "locker_wp_db_name" {
  default = ""
}

variable "locker_wp_db_password" {
  default = ""
}

resource "aws_instance" "locker_wordpress" {
  ami           = var.wordpress_ami
  instance_type = var.ec2_size
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ftp.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "locker-wordpress"
  }
}

resource "aws_security_group" "ftp" {
  name        = "ftp"
  description = "FTP security group"

  ingress {
    from_port        = 21
    to_port          = 21
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
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

output "locker-wordpress" {
  value = "A record: ${aws_instance.locker_wordpress.public_dns}"
}

output "locker-wp-db" {
  value = "mysql://${aws_db_instance.locker_wp_db.username}:${aws_db_instance.locker_wp_db.password}@${aws_db_instance.locker_wp_db.endpoint}/${aws_db_instance.locker_wp_db.name}"
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
