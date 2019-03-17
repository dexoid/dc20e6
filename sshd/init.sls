{% from "sshd/map.jinja" import map_sshd_settings with context %}

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
    - name: {{ map_sshd_settings['conf'] }}
    - source: salt://sshd/files/etc/ssh/sshd_config.j2
    - template: jinja
    - user: root
    - custom:
      params: {{ map_sshd_settings }}
      test: {{ map_sshd_settings['motd'] }}
    - watch_in:
      - service: openssh-server_run
