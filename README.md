aj-sitetest
====

configure test server using ansible and jenkins

## Description

## Requirement

ansible 1.9.4 or higher  
Jenkins  
Cloud servers (DigitalOcean,EC2)  

## Usage

### Create a Job on Jenkins

Clone https://github.com/chienowa/aj-sitetest.git  
Exec shell as follows

  ansible-playbook -i ${SERVER}, -u ec2-user pb-virtualhost.yml  --extra-vars "action=${ACTION} domain=${DOMAIN}";


## Licence

see LICENSE

## Author

[chienowa](https://github.com/chienowa)
