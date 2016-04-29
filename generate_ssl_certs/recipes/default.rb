#
# Cookbook Name:: generate_ssl_certs
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
directory '/etc/nginx' do
	action	:create
end

directory '/etc/nginx/ssl' do
	action	:create
end

execute 'generate_dhparams' do
	command	'openssl dhparam -out /etc/dhparams.pem 2048'
	creates	"/etc/dhparams.pem"
end

execute 'generate_certificate' do
	command	'openssl req -new -nodes -x509 -subj "/C=US/ST=Oregon/L=Portland/O=IT/CN=#{node[:domain_fqdn]}" -days 365 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -extensions v3_ca'
	creates	'/etc/nginx/ssl/server.crt'
end
