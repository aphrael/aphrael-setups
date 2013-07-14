name              "users_and_groups"
maintainer        "O.yuanying"
maintainer_email  "yuan-chef@fraction.jp"
license           "Apache 2.0"
description       "Managing Users and Groups."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "docker", "Installs/Configures Docker"

%w{ ubuntu }.each do |os|
  supports os
end

