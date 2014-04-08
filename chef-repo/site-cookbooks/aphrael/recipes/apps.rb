git_data_dir  = '/var/volumes/repositories'
rep2_data_dir = '/var/volumes/rep2'

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
  port "9872:9872"
  volume "#{git_data_dir}:/var/repos"
  action :run
  # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
end

docker_container 'rep2' do
  container_name 'rep2'
  image 'yuanying/rep2'
  # init_type nil
  detach true
  port "8081:8080"
  volume "#{rep2_data_dir}:/p2-php/data"
  action :run
  # subscribes :redeploy, "bash[docker/images/yuanying/mysql]"
end
