terraform {
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.12.26"
}


provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAWORTY4FXWDWAGX2E"
  secret_key = "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"
}

resource "aws_instance" "my-ec2" {
   ami = "ami-090717c950a5c34d3" 
   instance_type = "t2.micro"
   key_name = "terraform"
   vpc_security_group_ids = [aws_security_group.web-sg.id]
  
   tags = {
    Name = "Jenkins-2"
  }

}
#${file("~/.ssh/id_rsa")}"

resource "aws_security_group" "web-sg" {
  #vpc_id = "${aws_vpc.venkat_vpc.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }


}

resource "null_resource" "copy_execute" {

    connection {
    type = "ssh"
    host = aws_instance.my-ec2.public_ip
    user = "ubuntu"
    private_key = file("~/Downloads/terraform.pem")
    }
   provisioner "remote-exec" {
    inline = [ 
      "rm -rf /home/ubuntu/jenkinsjob" ,
      "git clone https://github.com/venkatesh-devops/jenkinsjob.git" ,
      "cd /home/ubuntu/jenkinsjob" ,
      "chmod +x tesh.sh" ,
      "sudo apt-get update -y" ,
      "sudo apt-get install -y dos2unix" ,
      "dos2unix tesh.sh" ,
      "bash tesh.sh" ,
      #"sudo systemctl status jenkins"
      #"consul join ${aws_instance.my-ec2.private_ip}",
    ]
  }
}
