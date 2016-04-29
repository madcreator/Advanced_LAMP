#
# Cookbook Name:: install_and_configure_nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

rpm_package 'rpmforge' do
	source	'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm'
	action	:install
end

rpm_package 'epel' do
	source	"http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm"
	action 	:install
end

rpm_package 'remi' do
	source	"http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
	action	:install
end

yum_package 'nginx' do
	action :install
end

service 'nginx' do
	action :enable
	action :restart
end

template '/etc/nginx/nginx.conf' do
	source 'nginx.conf.erb'
	owner 'root'
	group 'root'
	mode '0755'
end

execute "Allow http" do
	command	"firewall-cmd --zone=public --permanent --add-service=http"
end

execute "Allow https" do
	command	"firewall-cmd --zone=public --permanent --add-service=https"
end
