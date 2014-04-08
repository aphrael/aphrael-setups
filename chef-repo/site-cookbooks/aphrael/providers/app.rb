def load_current_resource
  @current_resource = Chef::Resource::NginxSiteVirtual.new(new_resource)
  @current_resource
end

action :install do
  directory new_resource.host_dir do
    owner new_resource.owner
    group new_resource.group
    recursive true
    action :create
  end

  if new_resource.image[:source]
    docker_image new_resource.image[:name] do
      source new_resource.image[:source]
      rm true
      action :build_if_missing
    end
  end

  docker_container new_resource.name do
    container_name new_resource.name
    image new_resource.image[:name]
    # init_type nil
    user new_resource.exec_user
    detach true
    port "#{new_resource.host_http_port}:#{new_resource.container_http_port}"
    volume "#{new_resource.host_dir}:#{new_resource.container_dir}"
    action :run
    # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
  end

  hostname  = new_resource.hostname || new_resource.name
  domain    = new_resource.domain   || node['aphrael']['default_domain'] || node['domain']
  nginx_site_virtual new_resource.name do
    server_name   "#{hostname}.#{domain}"
    document_root new_resource.host_dir
    auth_basic    new_resource.auth_basic
    upstream({
      name: new_resource.name,
      address: "localhost:#{new_resource.host_http_port}"
    })
  end
end
