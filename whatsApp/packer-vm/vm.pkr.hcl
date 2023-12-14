packer {
  required_plugins {
    amazon = {
      version = ">=1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_id" {
  type    = string
  default = "ami-058bd2d568351da34"
}

variable "app_name" {
  type    = string
  default = "ec2_app"
}

variable "ami_description" {
  type    = string
  default = "Debian-12 whatsapp"
}

variable "dev_account_id" {
  type    = string
  default = "485788354807"
}

variable "ami_regions" {
  type    = list(string)
  default = ["us-east-2", "us-west-1"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "source_ami" {
  type    = string
  default = "ami-0ec3d9efceafb89e0"
}

variable "ssh_username" {
  type    = string
  default = "admin"
}

variable "ami_name" {
  type    = string
  default = "Debain-12"
}



variable "device_name" {
  type    = string
  default = "/dev/xvda"
}

variable "volume_size" {
  type    = number
  default = 25
}

variable "date_format" {
  type    = string
  default = "YYYY_MM_DD_hh_mm_ss"
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "provisioner_webapp_source" {
  type    = string
  default = "./whatsApp.zip"
}

variable "provisioner_webapp_destination" {
  type    = string
  default = "/home/admin/whatsApp.zip"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "script" {
  type    = string
  default = "./setup.sh"
}

variable "USER" {
  type    = string
  default = "${env("USER")}"
}

variable "DATABASE" {
  type    = string
  default = "${env("DATABASE")}"
}

variable "PD" {
  type    = string
  default = "${env("PD")}"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "my-ami" {
  region          = "${var.aws_region}"
  ami_name        = "${var.ami_name}_${formatdate("${var.date_format}", timestamp())}"
  ami_description = "${var.ami_description}"
  ami_users       = ["${var.dev_account_id}"]
  ami_regions     = "${var.ami_regions}"
  instance_type   = "${var.instance_type}"
  source_ami      = "${var.source_ami}"
  ssh_username    = "${var.ssh_username}"

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "${var.device_name}"
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }
}

build {
  sources = ["source.amazon-ebs.my-ami"]

  provisioner "file" {
    source      = "${var.provisioner_webapp_source}"
    destination = "${var.provisioner_webapp_destination}"
  }

  provisioner "shell" {
    script = "${var.script}"
  }
}




