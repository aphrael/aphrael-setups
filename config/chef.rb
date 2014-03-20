set :application,     "AphraelServer"

set :solo_rb_template, File.dirname(__FILE__) + '/solo.rb.erb'

run_list :router, [
  'role[bootstrap]',
  'recipe[docker]',
  # 'recipe[virtualbox]',
  'recipe[nginx::source]',
  'recipe[nginx-site]',
  # 'recipe[dokku::bootstrap]',
  'recipe[docker-images]',
  # 'recipe[smbfs]'
]

task :test do
  set :user, 'vagrant'

  set :domain, "192.168.33.10.xip.io"
  role :router, "#{user}@192.168.33.10"
end

task :production do
  set :user, 'aphrael'

  set :ssh_flags, %w[-p 10021]

  set :domain, "oeilvert.org"
  role :router, "#{user}@oeilvert.org"
end
