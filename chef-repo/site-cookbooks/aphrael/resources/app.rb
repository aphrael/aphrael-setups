actions :install
default_action :install

attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]

attribute :hostname,    kind_of: [String]
attribute :domain,      kind_of: [String], default: node['domain']
attribute :auth_basic,  kind_of: [Hash]

attribute :image, kind_of: [Hash]

attribute :exec_user,           kind_of: [String]
attribute :host_http_port,      kind_of: [String, Fixnum], required: true
attribute :container_http_port, kind_of: [String, Fixnum], required: true
attribute :host_dir,            kind_of: [String], required: true
attribute :container_dir,       kind_of: [String], required: true

attribute :cookbook, :kind_of => [String], :default => 'aphrael'



