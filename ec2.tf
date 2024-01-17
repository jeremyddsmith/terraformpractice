resource "aws_instance" "main" {
    ami = data.aws_ssm_parameter.instance_ami
    instance_type = "t3.micro"
    key_name = "jdansible"
    subnet_id = aws_subnet.public[0].id
    tags = "jddterraform"
}