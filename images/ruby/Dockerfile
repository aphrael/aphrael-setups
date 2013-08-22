# Ruby
#
# VERSION               0.0.1

FROM      ubuntu
MAINTAINER O. Yuanying "yuan-docker@fraction.jp"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison nodejs subversion
RUN curl ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz | tar zxvf -
RUN cd ruby-2.0.0-p247 && ./configure && make && make install && gem install --no-ri --no-rdoc bundler
