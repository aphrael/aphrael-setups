include_recipe "logrotate"

gem_binaries_path = File.join(node.rbenv.root_path, "versions", node.nats_server.ruby.version, "bin")

rbenv_gem "nats" do
  rbenv_version node.nats_server.ruby.version
end

component_name = "nats-server"

ruby_path    = File.join(node.rbenv.root_path, "versions", node.nats_server.ruby.version, "bin")

config_file  = File.join(node.nats_server.config_dir, "#{component_name}.yml")
pid_file     = node.nats_server.pid_file
pid_dir      = File.dirname(pid_file)
log_file     = node.nats_server.log_file
log_dir      = File.dirname(log_file)
binary       = File.join(gem_binaries_path, "nats-server")

[node.nats_server.config_dir, pid_dir, log_dir].each do |dir|
  directory dir do
    recursive true
    # owner node[:cloudfoundry_common][:user]
    mode  '0755'
  end
end

template config_file do
  source   "#{component_name}.yml.erb"
  # owner    node.cloudfoundry_common.user
  mode     "0644"
  notifies :restart, "service[#{component_name}]"
end

template "/etc/init/#{component_name}.conf" do
  source   "upstart.conf.erb"
  variables(
    :component_name => component_name,
    :path        => ruby_path,
    :binary      => binary,
    :config_file => config_file
  )
  notifies :restart, "service[#{component_name}]"
end

link "/etc/init.d/#{component_name}" do
  to "/lib/init/upstart-job"
end

service component_name do
  supports :status => true, :restart => true
  action [:enable, :start]
end

logrotate_app component_name do
  cookbook "logrotate"
  path log_file
  frequency daily
  rotate 30
  create "644 root root"
end


