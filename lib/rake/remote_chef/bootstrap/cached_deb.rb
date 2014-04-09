
set :remote_chef_path, '/usr'

namespace :chef do
  namespace :bootstrap do
  end

  desc 'Install chef.'
  remote_task :bootstrap => :update_repository do
    sudo "dpkg -i #{remote_blob_dir}/chef_11.10.4-1.ubuntu.13.04_amd64.deb"
  end
end