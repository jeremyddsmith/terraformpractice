resource "aws_instance" "main" {
    ami = data.aws_ssm_parameter.instance_ami.value
    instance_type = "t3.micro"
    key_name = "jdansible"
    subnet_id = aws_subnet.public[0].id
    vpc_security_group_ids = ["sg-0e673f30eb234d1ba"]
    tags = {
        "Name" = "${var.default_tags.env}-EC2"
    }
}