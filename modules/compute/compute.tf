# create the key
resource "aws_key_pair" "test_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = {
    enviroment = "${var.enviroment}_key"
  }
}

output "amiId" {
  value = data.aws_ami.server_ami.id
}

resource "aws_instance" "test_instance" {
  ami               = data.aws_ami.server_ami.id
  instance_type     = var.instance_type
  availability_zone = "eu-west-2a"
  key_name          = aws_key_pair.test_key.id

  root_block_device {
    volume_size = var.volume_size
  }
  subnet_id              = var.public_subnet
  vpc_security_group_ids = [var.public_sg]
}
