
node[:groups].each do |g|
  group g[:name] if g[:primary]
end

node[:users].each do |u|

  home_dir = "/home/#{u[:name]}"

  user u[:name] do
    gid u[:gid]
    shell u[:shell]
    home home_dir
    supports :manage_home => true
  end

  if u[:public_key]
    directory "#{home_dir}/.ssh" do
      mode        '0700'
      owner       u[:name]
      group       u[:gid]
      action      :create
    end
    
    template "#{home_dir}/.ssh/authorized_keys" do
      source 'authorized_keys.erb'
      mode '0600'
      owner       u[:name]
      group       u[:gid]
      variables(
        :public_key => u[:public_key]
      )
    end
  end

  if /zsh/ =~ u[:shell]
    template "#{home_dir}/.zshenv" do
      mode "0644"
      source 'zshenv.erb'
    end

    template "#{home_dir}/.zshrc" do
      mode "0644"
      source 'zshrc.erb'
    end
  end
end

node[:groups].each do |g|
  unless g[:primary]
    group g[:name] do
      append true
      members g[:members]
    end
  end
end
