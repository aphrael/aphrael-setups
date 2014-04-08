actions :create
default_action :create

attribute :server_name,   kind_of: [String]
attribute :document_root, kind_of: [String]
attribute :auth_basic,    kind_of: [Hash]
attribute :upstream,      kind_of: [Hash]
