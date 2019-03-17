==================================================================
Примеры состояний firewalld and sshd states для 0x03 митапа dc20e6
==================================================================

Примеры pillars
=======================

Firewalld pillar

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
