/*

$ terraform apply
------------------------------------------------------------------------------------------------------------------------------
# Example 7 - Provision local/external 


provider "aws" {
 region = "ap-south-1"
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "web-server"
    "environment" = "dev"
 }
  provisioner "local-exec" {
    command = "echo ${aws_instance.instance01.public_ip} > ip_address.txt"
 }


}


$ terraform apply
------------------------------------------------------------------------------------------------------------------------------
provider "aws" {
 region = "ap-south-1"
}
 
resource "aws_instance" "instance01" {
 ami = "ami-09ba48996007c8b50"
 instance_type = "t2.micro"
 tags = {
 "Name" = "terraform-22"
 "environment" = "dev"
 }
   provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }
}


$ terraform apply


------------------------------------------------------------------------------------------------------------------------------
# Example 8 -  Defining Variable - Input / Output Variable


variable "region" {
  default = "ap-south-1"
}


provider "aws" {
 region = var.region
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "web-server"
    "environment" = "dev"
  }
}


output "ip" {
  value = aws_instance.instance01.public_ip


}


------------------------------------------------------------------------------------------------------------------------------
# Example 9 -  Defining Local Variable
locals {
 env = "forum"
 owner = "Ritesh-DevOps"
}


variable "region" {
  default = "ap-south-1"
}


provider "aws" {
 region = var.region
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "web-server"
    "environment" = local.env
    "owner" = local.owner
  }
}


output "ip" {
  value = aws_instance.instance01.public_ip


}




------------------------------------------------------------------------------------------------------------------------------






#Example 10 - Splitting the input, output and provider in different files
---------------------------------------
vim example.tf


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "web-server"
    "environment" = "dev"
 }
}


--------------------------------------
vim variables.tf 


variable "region" {
  default = "ap-south-1"
}


---------------------------------------
vim outputs.tf


output "ip" {
  value = aws_instance.instance01.public_ip
}
---------------------------------------
vim provider.tf


provider "aws" {
  region = var.region
}
---------------------------------------







*/


/*example -8
provider "aws" {
region = "ap-south-1" 
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "web-server"
    "environment" = "dev"
  }
}
resource "aws_eip" "newIP" {
 instance = aws_instance.instance01.id
 vpc = true
}
*/


/* example-6
provider "aws" {
 region = "ap-south-1"
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "nimphy-web-server"
    "environment" = "dev"
 }
depends_on = [aws_ebs_volume.diskSize]
}


resource "aws_ebs_volume" "diskSize" {
 availability_zone = "ap-south-1"
 size = 10

}


resource "aws_volume_attachment" "ebs_add2" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.diskSize.id
  instance_id = aws_instance.instance01.id


}


resource "aws_eip" "newIP" {
 instance = aws_instance.instance01.id
 vpc = true
}

*/




/*
View the tfstate file content in terraform
-------terraform show

Destroy the infrastructure
------terraform destroy
*/

/* example-3


provider "aws" {
region = "ap-south-1" 
}


resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "nimphy-web-server"
    "environment" = "dev"
  }
}
resource "aws_eip" "newIP" {
 instance = aws_instance.instance01.id
 vpc = true
}

*/

/* example-2

provider "aws" {
region = "ap-south-1" 
}
resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "nimphy-app-server"
    "environment" = "dev"
  }
}
resource "aws_instance" "instance02" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
 tags = {
    "Name"        = "nimphy-web-server"
    "environment" = "stage"
  }
 }
 */

/* example-1
provider "aws" {
    region     = "ap-south-1"
    access_key = "AKIAVRUVPKAUNXRA5PTO"
    secret_key = "ZFLAOMnti+qUCl6VpNQiyRJ0UgE5Oiw0HiuljwOm" 
  }

resource "aws_instance" "instance01" {
 ami = "ami-04db49c0fb2215364"
 instance_type = "t2.micro"
}
*/
