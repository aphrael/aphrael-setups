include_recipe 'docker'

git "/home/yuanying/aphrael-docker-images" do
  repository "https://github.com/aphrael/aphrael-docker-images.git"
  ['base', '1.8.7', '1.9.3', '2.0.0', '2.1'].each do |t|
    notifies :run, "bash[docker/images/yuanying/ruby/#{t}]", :immediately
  end
end

['base', '1.8.7', '1.9.3', '2.0.0', '2.1'].each do |t|
  bash "docker/images/yuanying/ruby/#{t}" do
    cwd "/home/yuanying/aphrael-docker-images/ruby/#{t}"
    code "docker build -t yuanying/ruby:#{t} ."
    action :nothing
  end
end




