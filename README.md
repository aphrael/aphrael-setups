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
    $ bundle exec rake chef:bootstrap to=test
    $ bundle exec rake chef:solo to=test
