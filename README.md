

1: Dockerize the application A multi-stage docker file is created and kept in the same directory


2: Provision the required infrastructure using Terraform 

    All configuration files are kept in the terraform directory 
    User data file is kept in the files directory 
    Modules were used to create infrastructure, separate modules for EC2, ELB and VPC are kept in the modules directory 
        - In EC2, Instances were created in the private subnet adn were attached below the Classic Load Balancer, the instances use SSM for login and management therefore keys were not created for the same 
        - In ELB, Classic Load Balancer was created, as required, and logs are being sent to the ELB bucket with 90 days retention 
        - In VPC, Public and private subnets were created with their corresponding IGW/NAT gateways, 3 NAT gateways were created for making the environment multi AZ, also, VPC flow logs are being sent to Cloudwatch


3: Jenkins was used to create pipeline 

    Pipeline file is kept in the same directory 
    Created and setup EC2 instance to install and setup jenkins and tested the CI file 
    Setup: Created Jenkins server, integrated with Sonarcube Plugin 
    Other additions: docker, maven, github webhook, docker hub and integrated jenkins node with our app server to enable deployment 


Screenshots:



Github-Webhook: ![Alt text](images/github-jenkins-web-hook.png?raw=true "Github-Jenkins-Webhook") 

Jenkins Node add: ![Alt text](images/node-add-jenkins.png?raw=true "Jenkins Node Addition") 

Pipelines: ![Alt text](images/pipelines.png?raw=true "Pipelines") 

Managed Nodes By Jenkins: ![Alt text](images/managed-nodes-by-jenkins.png?raw=true "Managed Nodes By jenkins Server")

Postman Put: ![Alt text](images/postman-put-api.png?raw=true "Postman PUT api call")

Postman Get: ![Alt text](images/postman-get-api-call.png?raw=true "Postman GET api call")

ELB Nodes: ![Alt text](images/elb-instances.png?raw=true "ELB Instances nodes status")