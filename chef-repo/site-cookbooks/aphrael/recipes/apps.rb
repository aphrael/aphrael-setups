
node[:aphrael][:apps].each do |k, v|
  aphrael_app k do
    owner v[:owner]
    group v[:group]
    hostname v[:hostname]
    domain v[:domain]
    auth_basic v[:auth_basic]
    image v[:image]
    exec_user v[:exec_user]
    host_http_port v[:host_http_port]
    container_http_port v[:container_http_port]
    host_dir v[:host_dir]
    container_dir v[:container_dir]
  end
end if node[:aphrael][:apps]
