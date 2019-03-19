===================================================================================
Примеры состояний firewalld и sshd states в готовом окружении для их разворачивания
===================================================================================

Требования
==========

* [Vagrant](https://www.vagrantup.com/)
* [Vbguest plugin for Vagrant](https://github.com/dotless-de/vagrant-vbguest)
* [VirtualBox](https://www.virtualbox.org/)

Быстрый старт
=============

#. Склонируйте проект и перейдите в его директорию
#. Отредактируйте переменные в *config.yml*
#. Отредактируйте/создайте pillar для удалённого сервера в *salt/pillar*
#. Выполните *vagrant up*
#. Добавьте выданный вам на прошлом шаге публичный ключ на удалённый сервер
#. Выполните *vagrant provision*

Примеры pillars
=======================

firewalld pillar:

.. code-block:: yaml

    firewalld:
      customservices:
        zabbix-server:
          ports:
            - '10051/tcp'
      zones:
        public:
          name:
            - eth0
          services:
            - ssh
            - http
            - https
          masquerade: False
          port_fwd:
            - 443:1935:tcp
          rich_rules:
            - 'rule family="ipv4" source address="1.2.3.4/32" service name="bacula-client" accept'

sshd pillar:

.. code-block:: yaml

    sshd:
      port: '2222'
      permitrootlogin: 'without-password'
      passwordauthentication: 'no'
      loglevel: 'VERBOSE'
      maxauthtries: 2
      maxsessions: 5
      challengeresponseauthentication: 'no'
      allowagentforwarding: 'no'
      allowtcpforwarding: 'no'
      x11forwarding: 'no'
      syslogfacility: 'AUTHPRIV'
      strictmodes: 'yes'
      clientaliveinterval: 30
      clientalivecountmax: 6

Дополнительная информация
=========================
* https://firewalld.org/
* https://fedoraproject.org/wiki/FirewallD/ru
* https://docs.saltstack.com/en/latest/ref/states/all/salt.states.firewalld.html
* https://www.openssh.com/manual.html
