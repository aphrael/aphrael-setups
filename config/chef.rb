set :application,     "AphraelServer"

run_list :router, [
  'role[bootstrap]',
  'recipe[nginx::source]',
  'recipe[docker]',
  'recipe[virtualbox]',
  'recipe[smbfs]'
]

task :test do
  set :user, 'vagrant'

  role :router, "#{user}@192.168.33.10"
end

task :production do
  set :user, 'aphrael'

  set :ssh_flags, %w[-p 10021]

  role :router, "#{user}@192.168.1.82"
end
