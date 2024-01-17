resource "aws_instance" "main" {
    ami = data.aws_ssm_parameter.instance_ami.value
    instance_type = "t3.micro"
    key_name = "jdansible"
    subnet_id = aws_subnet.public[0].id
    vpc_security_group_ids = ["sg-07ee03d9e41b765c6"] #must use your vpc's sg
    tags = {
        "Name" = "${var.default_tags.env}-EC2"
    }
    user_data = base64encode(file("C:\\Users\\Jeremy Local\\Documents\\Skillstorm\\Terraform\\user.sh"))
}