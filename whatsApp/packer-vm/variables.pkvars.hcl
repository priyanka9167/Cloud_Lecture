
source_ami = "ami-058bd2d568351da34"
ssh_username = "admin"
ami_name = "Debain-12"
date_format = "YYYY_MM_DD_hh_mm_ss"
aws_region = "us-east-1"
ami_users = ""
dev_account_id = "485788354807"
ami_regions = ["us-east-1", "us-west-1"]
instance_type = "t2.micro"
ami_description = "Debian-12 whatsapp"
delay_seconds = 120
max_attempts  = 50
device_name = "/dev/xvda"
volume_size = 25
volume_type = "gp2"

provisioner_webapp_source = "whatsApp.zip"
provisioner_webapp_destination = "/home/admin/whatsApp.zip"
script  = "./setup.sh"


