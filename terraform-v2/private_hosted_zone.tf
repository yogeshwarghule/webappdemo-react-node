resource "aws_route53_zone" "private" {
  name = "webapp.com"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = {
    Name = "Terraform Private Hosted Zone"
  }
}

resource "aws_route53_record" "backend_record" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "backend.webapp.com"
  type    = "A"
  ttl     = 300
  records = [var.app_server_private_ip]
}

resource "aws_route53_record" "database_record" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "database.webapp.com"
  type    = "A"
  ttl     = 300
  records = [var.db_server_private_ip]
}
