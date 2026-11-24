resource "aws_key_pair" "ssh-key" {
  key_name   = "id_ed25519.pub"
  public_key = file(var.ssh_public_key)
}

resource "aws_instance" "api" {
  ami                         = var.vm_specification["api"].boot_image
  instance_type               = var.vm_specification["api"].instance_type
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true

  key_name = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.environment}-api-s9277817"
  }
}

resource "aws_instance" "web" {
  ami                         = var.vm_specification["web"].boot_image
  instance_type               = var.vm_specification["web"].instance_type
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh-access.id]

  key_name = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.environment}-web-s9277817"
  }
}
