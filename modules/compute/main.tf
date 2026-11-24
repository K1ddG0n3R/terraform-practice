resource "aws_key_pair" "ssh-key" {
  key_name   = "id_ed25519.pub"
  public_key = file(var.ssh-public-key)
}

resource "aws_instance" "api" {
  ami                         = var.vm-specification["api"].boot_disk
  instance_type               = var.vm-specification["api"].instance_type
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true

  key_name = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.environment}-api-s9277817"
  }
}

resource "aws_instance" "web" {
  ami                         = var.vm-specification["web"].boot_disk
  instance_type               = var.vm-specification["web"].instance_type
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true

  key_name = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.environment}-web-s9277817"
  }
}
