#
# Cookbook Name:: install_and_configure_httpd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

yum_package 'httpd' do
	action	:install
end

template '/etc/httpd/conf.d/000-default.conf' do
	source	'000-default.conf.erb'
	owner	'root'
	group	'root'
	mode	'0755'	
end

template '/etc/httpd/conf/httpd.conf' do
	source	'httpd.conf.erb'
	owner	'root'
	group	'root'
	mode	'0755'
end

yum_package 'several_more_packages' do
	package_name ["php", "mc", "wget", "vim" ]
	action	:install
end

directory '/var/www/html' do
	action :create
	owner	'apache'
	group	'apache'
	mode	'0755'
end

file '/var/www/html/phpinfo.php' do
	content '<?php phpinfo();'
	owner	'apache'
	group	'apache'
	mode	'0755'
end


service 'httpd' do
        action  :restart
end

