# # Go and grab the latest Windows Server 2012 image from Amazon
# data "aws_ami" "amazonlinux" {
#   most_recent = true

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }

#   filter {
#     name   = "name"
#     values = ["Amazon Linux AMI*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

resource "aws_instance" "linuxec2" {
  # ami                         = "${data.aws_ami.amazonlinux.id}"
  ami                         = "ami-0b33d91d"
  instance_type               = "t2.small"
  associate_public_ip_address = "true"
  subnet_id                   = "subnet-1a152c53"

  key_name = "${aws_key_pair.mykey.key_name}"

  # Run the powershell command to add a user to the instance
  # Open the firewall port for Remote Desktop
  # Make sure service is set to autostart and started


  # Copy a file from this machine to the remote machine
  # provisioner "file" {
  #   source = "script.sh"
  #   destination = "/tmp/script.sh"
  # }


  # Create a remote exec connection
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "sudo /tmp/script.sh"
  #   ]
  # }


  #   connection {
  #   user = "${var.INSTANCE_USERNAME}"
  #   private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  # }

  # Create the standard set of tags
  tags {
    App          = "TerraformWindowStarterApp"
    Name         = "TerraformWindowStarterInstance"
    CreationTime = "${timestamp()}"
    Custodian    = "present"
  }
}

# Create a key pair in aws
resource "aws_key_pair" "mykey" {
  key_name   = "WindowsLoggingKey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
