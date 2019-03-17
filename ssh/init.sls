{% from "ssh/map.jinja" import map_ssh_settings with context %}

openssh-server:
  pkg.installed:
    - name: openssh-server
    - refresh: True

openssh-server_run:
  service.running:
    - name: {{ map_ssh_settings['service'] }}
    - enable: True

openssh-server_conf:
  file.managed:
    - name: {{ map_ssh_settings['conf'] }}
    - source: salt://ssh/files/etc/ssh/sshd_config.j2
    - template: jinja
    - user: root
    - custom:
      params: {{ map_ssh_settings }}
      test: {{ map_ssh_settings['motd'] }}
    - watch_in:
      - service: openssh-server_run
