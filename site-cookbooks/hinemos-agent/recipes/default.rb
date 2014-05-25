#
# Cookbook Name:: hinemos-agent
# Recipe:: default
#
# Copyright 2014, NTTDATA INTELLILINK
#
# All rights reserved - Do Not Redistribute
#

log "Install or update packages"
%w{rsyslog net-snmp krb5-workstation expect}.each do |pkg|
  yum_package pkg do
    arch    'x86_64'
  end
end

log "Retrieve hinemos-agent archive"
filename = "hinemos_agent-4.1.1_rhel5-rhel6.tar.gz"
extract_name = "Hinemos_Agent-4.1.1_rhel5-rhel6"
register = "hinemos.tgz"
register_extract_name = "hinemos"

cookbook_file "/tmp/#{filename}" do
  source "#{filename}"
end

log "Unpack and execute installer"
script "install_hinemos_agent" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    tar xzvf /tmp/#{filename} -C /tmp/
    cd /tmp/#{extract_name}/
    bash agent_installer_EN.sh -i -m 172.24.4.227
  EOL
end


log "Register to hinemos manager"
cookbook_file "/tmp/#{register}" do
  source "#{register}"
end

script "register_manager" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    tar xvzf /tmp/#{register} -C /tmp
    cd /tmp/#{register_extract_name}
    python node_regist.py -M 192.168.27.145 -U hinemos -w hinemos -A 172.24.4.227 -n cookbook
  EOL
end

