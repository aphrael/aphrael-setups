email_data_dir = '/var/volumes/emails'

user 'vmail' do
  uid 150
  gid 8
  home email_data_dir
end

directory email_data_dir do
  owner 'vmail'
  group 'mail'
  recursive true
  action :create
end

docker_image 'yuanying/email-server' do
  source 'github.com/yuanying/docker-email-server'
  rm true
  action :build_if_missing
end

docker_container 'email-server' do
  container_name 'email-server'
  image 'yuanying/email-server'
  detach true
  link ['mysql:mysql']
  env [
    "POSTFIX_MYSQL_PASSWORD=#{node['common_password']}",
    "POSTFIXADMIN_SETUP_PASSWORD=#{node['postfixadmin']['setup_password']}"
  ]
  hostname node['email-server']['hostname']
  port ["25:25", "993:993", "8080:8080"]
  volume "#{email_data_dir}:/var/vmail"
  action :run
end