def load_current_resource
  @current_resource = Chef::Resource::NginxSiteVirtual.new(new_resource)
  @current_resource
end

action :create do
  basic_file = "#{node[:nginx][:dir]}/#{new_resource.name}.htpasswd"
  server_name    = new_resource.server_name   || "#{new_resource.name}.#{node['nginx-site']['default_domain']}"
  document_root  = new_resource.document_root || File.join(node['nginx-site']['document_root_parent'], new_resource.name)

  template "#{node[:nginx][:dir]}/sites-available/#{new_resource.name}" do
    source "site.conf.erb"
    variables(
      :server_name    => new_resource.server_name,
      :name           => new_resource.name,
      :document_root  => new_resource.document_root,
      :basic_file     => basic_file,
      :auth_basic     => new_resource.auth_basic,
      :upstream       => new_resource.upstream
    )
    notifies :reload, resources(:service => "nginx")
  end
  if new_resource.auth_basic
    template basic_file do
      source "htpasswd.erb"
      variables(
        :params         => new_resource.auth_basic
      )
      notifies :reload, resources(:service => "nginx")
    end
  end
  link "#{node[:nginx][:dir]}/sites-enabled/#{new_resource.name}" do
    to "#{node[:nginx][:dir]}/sites-available/#{new_resource.name}"
    notifies :reload, resources(:service => "nginx")
    not_if do ::File.symlink?( "#{node[:nginx][:dir]}/sites-enabled/#{new_resource.name}") end
  end
  new_resource.updated_by_last_action(true)
end
