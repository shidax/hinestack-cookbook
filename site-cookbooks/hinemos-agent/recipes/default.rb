#
# Cookbook Name:: hinemos-agent
# Recipe:: default
#
# Copyright 2014, NTTDATA INTELLILINK
#
# All rights reserved - Do Not Redistribute
#

log "Install or update packages"
%w{java-1.7.0-openjdk, rsyslog, net-snmp}.each do |pkg|
  package pkg do
    action :install
  end
end

