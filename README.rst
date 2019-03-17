==================================================================
Примеры состояний firewalld and sshd states для 0x03 митапа dc20e6
==================================================================

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
            - zabbix-server
            - http
            - https
            - bacula-client
            - dns
            - imap
            - imaps
            - smtp
            - smtps
            - pop3
            - pop3s
            - smtp-submission
          masquerade: True
          port_fwd:
            - 443:1935:tcp
          rich_rules:
            - 'rule family="ipv4" source address="1.2.3.4/32" service name="zabbix-agent" accept'

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
