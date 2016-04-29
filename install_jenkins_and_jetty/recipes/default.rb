#
# Cookbook Name:: install_jenkins_and_jetty
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

yum_package 'java-1.8.0-openjdk.x86_64' do
	action :install
end


remote_file '/tmp/jetty.tar.gz' do
	source	"#{node['jetty_url']}"
	owner	'root'
	group	'root'
	mode	'0755'
	action	:create
	not_if{ ::File.exists?("/tmp/jetty.tar.gz")}
end

user 'jetty' do
        comment 'Jetty user'
        home    '/opt/jetty'
        shell   '/bin/bash'
	action	[ :create, :modify ]
end

group 'jetty' do
        action  :create
        members 'jetty'
        append  true
end

execute "untar" do
	user	'jetty'
	cwd	'/tmp/'
	action	:run
	command	"tar zxvf /tmp/jetty.tar.gz -C /tmp"
	creates	"/opt/jetty-distribution-9.3.8.v20160314"
end

execute "Rename jetty dir" do
	user	'root'
	group	'jetty'
	cwd	'/opt'
	action	:run
	command	"mv #{node['jetty_original_dir']} /opt/jetty"
	creates	'/opt/jetty/bin/jetty.sh'
end

execute "Chown" do
	user	'root'
	cwd	'/opt'	
	command	'chown jetty:jetty /opt/jetty -R'
end

execute "Create init script" do
	user	'root'
	command	"ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty"
	creates	"/etc/init.d/jetty"
end

template '/etc/default/jetty' do
	source	'jetty.conf.erb'
	owner	'root'
	group	'root'
	mode	'0755'
end

template '/opt/jetty/start.ini' do
	source	'jetty_start.ini.erb'
	owner	'jetty'
	group	'jetty'
	mode	'0755'
end

directory '/opt/jetty/webapps' do
	action	:create
end

remote_file '/opt/jetty/webapps/jenkins.war' do
	source	"https://updates.jenkins-ci.org/latest/jenkins.war"
	owner	'jetty'
	group	'jetty'
	mode	'0755'
	not_if{ ::File.exists?("/opt/jetty/webapps/jenkins.war")}
end

template '/opt/jetty/webapps/jenkins.xml' do
	source	'jenkins.xml'
	owner	'jetty'
	group	'jetty'
	mode	'0755'
end

service	'jetty' do
	action	:enable
end

execute 'Jetty restart' do
	command	"/etc/init.d/jetty restart"
end
