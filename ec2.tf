resource "aws_instance" "main" {
  ami                    = data.aws_ssm_parameter.instance_ami.value
  instance_type          = "t3.micro"
  key_name               = "jdansible"
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = ["aws_vpc.main.default_security_group_id"] #default sg for vpc
  tags = {
    "Name" = "${var.default_tags.env}-EC2"
  }
  user_data = base64encode(file("user.sh"))
}

# # output "ec2_ssh_command" {
# #     value = "ssh -i vbansible.pem ubuntu@ec2-${replace(aws_instance.main.public_ip, ".", "-")}.compute-1.amazonaws.com"