resource "aws_ecr_repository" "main_ecr" {
    name = "web_app"
    image_tag_mutability = "MUTABLE"
}