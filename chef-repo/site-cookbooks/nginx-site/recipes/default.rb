
if node[:'nginx-site'] && node[:'nginx-site'][:virtuals]
  node[:'nginx-site'][:virtuals].each do |k, v|
    nginx_site_virtual k do
      server_name   v[:server_name]
      document_root v[:document_root]
      auth_basic    v[:auth_basic]
      upstream      v[:upstream]
    end
  end
end
