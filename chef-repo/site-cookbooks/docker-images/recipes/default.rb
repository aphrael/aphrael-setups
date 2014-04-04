include_recipe 'docker'

git "/home/yuanying/aphrael-docker-images" do
  repository "https://github.com/aphrael/aphrael-docker-images.git"
  action :sync
end

['base', '1.8.7', '1.9.3', '2.0.0', '2.1'].each do |t|
  bash "docker/images/yuanying/ruby/#{t}" do
    cwd "/home/yuanying/aphrael-docker-images/ruby/#{t}"
    code "docker build -t yuanying/ruby:#{t} ."
    action :run
    not_if "docker images | grep yuanying/ruby | grep #{t}"
    subscribes :sync, "git[/home/yuanying/aphrael-docker-images]"
  end
end

bash "docker/images/yuanying/mysql" do
  cwd "/home/yuanying/aphrael-docker-images/mysql"
  code "docker build -t yuanying/mysql ."
  action :run
  not_if "docker images | grep yuanying/mysql"
  subscribes :sync, "git[/home/yuanying/aphrael-docker-images]"
end

bash "docker/images/yuanying/mongodb:2.4.5" do
  cwd "/home/yuanying/aphrael-docker-images/mongodb"
  code "docker build -t yuanying/mongodb:2.4.5 ."
  action :run
  not_if "docker images | grep yuanying/mongodb | grep 2.4.5"
  subscribes :sync, "git[/home/yuanying/aphrael-docker-images]"
end

mysql_data_dir = '/home/yuanying/mysql'
directory mysql_data_dir do
  action :create
end
docker_container 'mysql' do
  container_name 'mysql'
  image 'yuanying/mysql'
  detach true
  port '3306:3306'
  volume "#{mysql_data_dir}:/var/lib/mysql"
  action :run
end

mongodb_data_dir = '/home/yuanying/mongodb/data'
directory mongodb_data_dir do
  recursive true
  action :create
end
docker_container 'mongodb' do
  container_name 'mongodb'
  image 'yuanying/mongodb:2.4.5'
  detach true
  port '27017:27017'
  volume "#{mongodb_data_dir}:/data"
  action :run
end
