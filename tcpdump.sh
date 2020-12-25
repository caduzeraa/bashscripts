#!/bin/bash
sudo apt install tshark awscli net-tools -y
sudo tshark -i ens5 -a duration:60 -w /capture-output.pcap
AWS_ACCESS_KEY_ID=AKIAXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
REGION=xxxxxxxx
ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
NAME=$(aws ec2 describe-tags --filters Name=resource-id,Values=$ID Name=key,Values=Name --region $REGION --query Tags[].Value --output text)
sudo mv /capture-output.pcap /home/ubuntu/
sudo tar -czvf dump.tar.gz capture-output.pcap
aws s3 cp dump.tar.gz s3://gm-pentest-files/25122020/$NAME/dump.tar.gz
unset AWS_ACCESS_KEY_ID && unset AWS_SECRET_ACCESS_KEY && unset REGION
sudo rm -f dump.tar.gz
sudo rm -f /capture-output.pcap