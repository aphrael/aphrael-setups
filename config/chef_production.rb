set :user, 'aphrael'

set :ssh_flags, %w[-p 10021]

role :router, "#{user}@192.168.1.82"
