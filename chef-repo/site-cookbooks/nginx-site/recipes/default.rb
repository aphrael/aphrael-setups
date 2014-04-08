
if node[:'nginx-site']
  node[:'nginx-site'].each do |k, v|
    basic_file = "#{node[:nginx][:dir]}/#{k}.htpasswd"

    template "#{node[:nginx][:dir]}/sites-available/#{k}" do
      source "site.conf.erb"
      variables(
        :server_name    => v[:server_name],
        :name           => k,
        :document_root  => v[:document_root],
        :basic_file     => basic_file,
        :params         => v
      )
      notifies :reload, resources(:service => "nginx")
    end
    if v[:auth_basic]
      template basic_file do
        source "htpasswd.erb"
        variables(
          :params         => v[:auth_basic]
        )
        notifies :reload, resources(:service => "nginx")
      end
    end
    if v[:ssl]
      cookbook_file "#{node[:nginx][:dir]}/#{v[:ssl][:certificate]}" do
        source v[:ssl][:certificate]
        owner node[:nginx][:user]
        mode 0600
      end
      cookbook_file "#{node[:nginx][:dir]}/#{v[:ssl][:certificate_key]}" do
        source v[:ssl][:certificate_key]
        owner node[:nginx][:user]
        mode 0600
      end
    end
    link "#{node[:nginx][:dir]}/sites-enabled/#{k}" do
      to "#{node[:nginx][:dir]}/sites-available/#{k}"
      notifies :reload, resources(:service => "nginx")
      not_if do ::File.symlink?( "#{node[:nginx][:dir]}/sites-enabled/#{k}") end
    end
  end
end
