default['nginx-site']['default_domain']       = node['domain']
default['nginx-site']['document_root_parent'] = node['nginx']['dir'] + '/html'