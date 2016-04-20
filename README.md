# advanced_lamp
Ansible playbook to install Apache+PHP and Jetty+Jenkins behind of Nginx as reverse proxy<br>

<p>Jetty - 8081/tcp - https://0.0.0.0/jenkins</p>
<p>Apache - 8080/tcp </p>
<p>Nginx - 80/tcp and 443/tcp <b>(self-signed cert)</b></p>

Before deploy, please change IP in inventory file to match your server(s)<br>
<b>NOTE: Server should restarted after deployment to disable SELINUX and restart all services.</b>

