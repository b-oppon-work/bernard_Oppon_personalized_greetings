#!/bin/bash


image_id="ami-04a81a99f5ec58529"
instance_type="t2.micro"
key_name="Bernard_22_june_24_ssh"
security_groups="launch-wizard-5"

aws ec2 run-instances \
--image-id $image_id \
--instance-type $instance_type \
--key-name $key_name \
--security-groups $security_groups \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]"