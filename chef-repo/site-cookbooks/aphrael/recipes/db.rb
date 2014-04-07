include_recipe 'docker'
include_recipe 'database::mysql'

mysql_data_dir = '/var/volumes/mysql'

directory mysql_data_dir do
  recursive true
  action :create
end
docker_container 'mysql' do
  container_name 'mysql'
  image 'yuanying/mysql'
  # init_type nil
  detach true
  env ["MYSQL_ROOT_PASSWORD=#{node['common_password']}"]
  port "3306:3306"
  volume "#{mysql_data_dir}:/var/lib/mysql"
  action :run
  # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
end

mysql_connection_info = {:host => "127.0.0.1",
                         :username => 'root',
                         :port => node['mysql']['server_port'],
                         :password => node['mysql']['server_root_password']}


node[:mysql][:databases].each do |db|
  mysql_database db[:name] do
    connection mysql_connection_info
    encoding db[:encoding]
    action :create
  end
end

node[:mysql][:users].each do |user|
  mysql_database_user user[:name] do
    connection mysql_connection_info
    host user[:host]
    password user[:password]
    database_name user[:database]
    privileges [:all]
    action [:create, :grant]
  end
end
