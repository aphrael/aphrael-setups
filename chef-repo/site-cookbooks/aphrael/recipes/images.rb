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
    subscribes :run, "git[/home/yuanying/aphrael-docker-images]"
  end
end

bash "docker/images/yuanying/mysql" do
  cwd "/home/yuanying/aphrael-docker-images/mysql"
  code "docker build -t yuanying/mysql ."
  action :run
  not_if "docker images | grep yuanying/mysql"
  # notifies :redeploy, "docker_container[mysql]"
  subscribes :run, "git[/home/yuanying/aphrael-docker-images]"
end


