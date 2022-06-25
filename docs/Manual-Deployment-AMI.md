# Deployment Guide (AMI)

This guide outlines the setup for a 3 tier web application using pre-made AMIs. The AMIs are currently not publicly available.
For automated deployment with terraform, please refer to `TF-deployment-with-ami.md`.

## Prerequisites
1. Web Server AMI (React + Nginx) (ami-0d38e3348f242b184)
2. App Server AMI (Node) (ami-01bfc31f1287cbd11) (Note: This is AppServer v1 AMI, where pm2 has not been configured to automatically start. This is because if we use the v3 AMI, it will error out since the private IP addresses are not hardcoded with Terraform)
3. Database Server AMI (MySQL) (ami-01a02370342aded44)

## 1. Create security groups
The following security groups are recommended for the 3 different EC2 instances. 

1. Web Server Inbound Rules (Name: WebServerSecurityGroup)
    * Allow HTTP, port 80 from ANYWHERE
    * Allow SSH, port 22, from ANYWHERE
2. App Server Inbound Rules (Name: AppServerSecurityGroup)
    * Allow TCP, custom port 8081, from ANYWHERE
        * This port can be any number set by the backend. Instead of allowing traffic from ANYWHERE, you may specify the private IP of the Web Server instead for limited access.
    * Allow SSH, port 22, from ANYWHERE
3. Database Server Inbound Rules (Name: DatabaseServerSecurityGroup)
    * Allow MySQL, port 3306, from ANYWHERE
        * You may allow traffic from the App Server private IP address instead only.
    * Allow SSH, port 22, from ANYWHERE

## 2. Launch Instances
Use the following configurations:
### 2.1 Web Server
* AMI: WebServer - v1 (React Nginx)
* Security group: WebServerSecurityGroup
* Key pair: Create or use an existing key pair
* Instance type: T2.micro

### 2.2 App Server
* AMI: AppServer - v1 (Node)
* Security group: WebServerSecurityGroup
* Key pair: Create or use an existing key pair
* Instance type: T2.micro

### 2.3 Database Server
* AMI: DatabaseServer - v1 (MySql)
* Security group: DatabaseServerSecurityGroup
* Key pair: Create or use an existing key pair
* Instance type: T2.micro

## 3. Configure App Server
1. In EC2 console, click on the **App** Server instance &#8594; Connect &#8594; EC2 Instance Connect &#8594; Set username as ubuntu instead of root and click connect. 
2. Edit ```index.js``` to point the mysql connection at the Database Server private IP.
```js script
const db = mysql2.createConnection({
    user: "myuser",
    host: "localhost", // REPLACE WITH DB SERVER PRIVATE IP ADDRESS
    password: "mypass",
    database: "employee_db"
})
```

To ensure that there are no issues, run 
```
node index.js
```
If there are no errors, the connection works and you can use pm2 as the process manager to run the backend. Ctrl + C to close the current process and run
```
pm2 start index.js
```
You may check the status of pm2 as well using the following command
```
pm2 status
```

## 4. Configure Web Server
1. In EC2 console, click on the **Web** Server instance &#8594; Connect &#8594; EC2 Instance Connect &#8594; Set username as ubuntu instead of root and click connect. 
2. Configure Nginx to proxy api requests to the Node server. First, open the following file for editing
```
sudo vim /etc/nginx/sites-available/default
```
3. The file should look like this. Under ```location /api```, replace localhost with the private IP address of the App Server.
```
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/build;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri /index.html $uri/ =404;
    }
    
    location /api {
        # Replace localhost with App Server IP
        proxy_pass http://localhost:8081; 
    }
}
```

4. Restart nginx
```
sudo systemctl restart nginx
```

## Test application
1. Go the the Public IPv4 DNS of the Web Server instance. Ensure that you are using HTTP instead of HTTPS. The application should be working as intended.