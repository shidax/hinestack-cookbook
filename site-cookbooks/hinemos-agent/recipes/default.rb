#
# Cookbook Name:: hinemos-agent
# Recipe:: default
#
# Copyright 2014, NTTDATA INTELLILINK
#
# All rights reserved - Do Not Redistribute
#

log "Install or update packages"
%w{rsyslog.x86_64 net-snmp.x86_64}.each do |pkg|
  package pkg
end

log "Retrieve hinemos-agent archive"
filename = "hinemos_agent-4.1.1_rhel5-rhel6.tar.gz"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

log "Unpack and execute installer"
script "install_hinemos_agent" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    tar xzvf /tmp/#{filename} -C
    cd /tmp/#{filename}/
    bash agent_installer_all
  EOL
end

