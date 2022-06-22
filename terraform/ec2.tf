# see variables.tf for configuration
resource "aws_instance" "web_server" {
    ami = var.web_server_ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    subnet_id = element(aws_subnet.public_subnet.*.id, 0)
    key_name = "lz-us-west-2"
    tags = {
      "Name" = "Web_Terraform"
    }
}

resource "aws_instance" "app_server" {
    ami = var.app_server_ami
    instance_type = var.instance_type
    subnet_id = element(aws_subnet.private_subnet.*.id, 0)
    vpc_security_group_ids = [aws_security_group.app_server_sg.id]
    key_name = "lz-us-west-2"
    tags = {
        "Name" = "App_Terraform"
    }
}

resource "aws_instance" "db_server" {
    ami = var.app_server_ami
    instance_type = var.instance_type
    subnet_id = element(aws_subnet.private_subnet.*.id, 0)
    vpc_security_group_ids = [aws_security_group.db_server_sg.id]
    key_name = "lz-us-west-2"
    tags = {
        "Name" = "DB_Terraform"
    }
}