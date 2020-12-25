urls=x.xxx.x.xx
for url in urls; do
    scp -i "smarthub-devops.pem" tcpdump.sh ubuntu@"$url":/home/ubuntu/
    ssh -i "smarthub-devops.pem" -oStrictHostKeyChecking=no ubuntu@"$url" "sudo chmod +x ./tcpdump.sh;./tcpdump.sh;sudo rm -f tcpdump.sh"
done