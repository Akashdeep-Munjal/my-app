#!/bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

# sleep 20

sudo echo nameserver 8.8.8.8 > /etc/resolv.conf

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>OneMuthoot - APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>OneMuthoot - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html


##################
## Installing Docker
###

sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on



##################
## Adding jdk to add instances as Jenkins agent to Deploy App
###

sudo amazon-linux-extras install java-openjdk11 -y



# curl -sO http://3.109.2.136:8080/jnlpJars/agent.jar
# java -jar agent.jar -jnlpUrl http://3.109.2.136:8080/computer/my%2Dapp%2D2/jenkins-agent.jnlp -secret 5d164961f812dd93063cda79bd329dbfba0cdd90d08ee4e313615ea0912352ea -workDir "/opt/jenkins"