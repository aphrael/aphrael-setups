# Aphrael Setups

Aphrael 用サーバのセットアップスクリプト。

## テストサーバの構築

### Requirement

-   Virtualbox
-   Vagrant

### テストサーバ生成

    $ cd $TEST_SERVER_VAGRANT_ROOT
    $ git clone https://github.com/aphrael/aphrael-setups.git
    $ cd aphrael-setups
    $ vagrant up

### セットアップ

    $ cd $TEST_SERVER_VAGRANT_ROOT/aphrael-setups
    $ bundle install
    $ scp ~/.ssh/id_dsa.pub vagrant@192.168.33.10:~/
    $ vagrant ssh
    vagrant@precise64:~$ cat id_dsa.pub >> ./ssh/authorized_keys
    vagrant@precise64:~$ sudo apt-get install curl
    vagrant@precise64:~$ exit
    $ bundle exec rake chef:bootstrap to=test
    $ bundle exec rake chef:solo to=test

## 秘密設定

    # config/chef.private.rb
    set :common_password, 'SECRET_PASSWORD'
    set :private_options, {
      postfixadmin: {
        setup_password: '1111111111111111111111:111111111111111111111111111111'
      }
    }

## TODO

-   smbfs
-   /home/vmail
    -   Add vmail(id:150)/mail(gid:8) user
