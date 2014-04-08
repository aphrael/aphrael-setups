git_data_dir  = node['nginx-site']['repos']['document_root']
rep2_data_dir = node['nginx-site']['rep2']['document_root']

directory git_data_dir do
  recursive true
  action :create
end
directory rep2_data_dir do
  recursive true
  action :create
end

docker_container 'git-repository' do
  container_name 'git-repository'
  image 'yuanying/grack'
  # init_type nil
  detach true
  port "node['nginx-site']['repos']['upstream']['port']:9872"
  volume "#{git_data_dir}:/var/repos"
  action :run
  # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
end

docker_container 'rep2' do
  container_name 'rep2'
  image 'yuanying/rep2'
  # init_type nil
  detach true
  port "node['nginx-site']['rep2']['upstream']['port']:8080"
  volume "#{rep2_data_dir}:/p2-php/data"
  action :run
  # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
end
