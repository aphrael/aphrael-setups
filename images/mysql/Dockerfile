# MySQL
#
# VERSION               0.0.1

FROM      ubuntu
MAINTAINER O. Yuanying "yuan-docker@fraction.jp"

ADD my.cnf /etc/mysql/my.cnf
RUN apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

RUN apt-get install -y -o Dpkg::Options::="--force-confold" mysql-common
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mysql-server
RUN mysql_install_db
ENV ROOT_PASSWORD root_password
RUN (/usr/bin/mysqld_safe &); sleep 10; echo "grant all privileges on *.* to root@'%' IDENTIFIED BY '${ROOT_PASSWORD}';" | mysql -u root

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]
