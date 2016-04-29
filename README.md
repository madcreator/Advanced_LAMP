Advanced_lamp (Chef)
Several Chef recipes to install Apache+PHP and jetty+Jenkins behind of Nginx as reverse proxy

Jetty - 8081/tcp - https://0.0.0.0/jenkins
Apache - 8080/tcp
Nginx - 80/tcp redirected to 443/tcp (self-signed cert)

Roles used:
<table><tr><td>Frontend<td>Backend<td>Jenkins</td></tr>
<tr><td>
<pre>
{
  "name": "frontend",
  "description": "Nginx",
  "json_class": "Chef::Role",
  "default_attributes": {
    "domain_fqdn": "chef-client",
    "frontend_url": "https://chef-client"
  },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[general_configuration]",
    "recipe[generate_ssl_certs]",
    "recipe[install_and_configure_nginx]"
  ],
  "env_run_lists": {

  }
}
</pre>
<td>
<pre>
{
  "name": "backend",
  "description": "Apache",
  "json_class": "Chef::Role",
  "default_attributes": {
    "domain_fqdn": "chef-client",
    "backend_port": 8080,
    "jenkins_port": 8081
  },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[general_configuration]",
    "recipe[install_and_configure_httpd]"
  ],
  "env_run_lists": {

  }
}
</pre>
<td>
<pre>
{
  "name": "jenkins",
  "description": "Jenkins + Jetty",
  "json_class": "Chef::Role",
  "default_attributes": {
    "jetty_url": "http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-9.3.8.v20160314.tar.gz",
    "jetty_original_dir": "/tmp/jetty-distribution-9.3.8.v20160314",
    "jetty_port": 8081
  },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[general_configuration]",
    "recipe[install_jenkins_and_jetty]"
  ],
  "env_run_lists": {

  }
}

</pre>
</td></tr>
</table>
backend
jenkins

Before deploy, please change domain_fqdn variable in roles.
NOTE: Server should restarted after deployment to disable SELINUX and restart all services.
