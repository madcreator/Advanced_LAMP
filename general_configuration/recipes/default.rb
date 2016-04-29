#
# Cookbook Name:: general_configuration
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
template '/etc/selinux/config' do
	source	'selinux_config.erb'
	owner	'root'
	group	'root'
	mode	'0755'
end
