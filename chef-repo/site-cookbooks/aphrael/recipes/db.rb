include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
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
