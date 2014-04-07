set :application,     "AphraelServer"

set :solo_rb_template, File.dirname(__FILE__) + '/solo.rb.erb'
set(:ssh_flags) {['-o', "StrictHostKeyChecking=no"]}#, '-i', ssh_private_key]}


run_list :router, [
  'role[bootstrap]',
  'recipe[aphrael::utils]',
  'recipe[device-mapper]',
  # 'recipe[aufs]',
  'recipe[docker]',
  'recipe[nginx::source]',
  'recipe[nginx-site]',
  'recipe[aphrael::images]',
  'recipe[aphrael::db]',
  'recipe[aphrael::email-server]',
  # 'recipe[smbfs]'
]

secret_config_file = File.join(File.dirname(__FILE__), 'chef.private.rb')
if File.exist?(secret_config_file)
  load(secret_config_file)
else
  puts "secret config file is not found: #{secret_config_file}"
  exit 1
end

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
