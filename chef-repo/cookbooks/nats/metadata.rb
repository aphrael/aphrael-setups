name              "nats"
maintainer        "O.yuanying"
maintainer_email  "yuan-chef@fraction.jp"
license           "Apache 2.0"
description       "Nats server."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "nats", "Installs/Configures Nats server."

%w{ apt rbenv logrotate }.each do |cb|
  depends cb
end

%w{ ubuntu }.each do |os|
  supports os
end

