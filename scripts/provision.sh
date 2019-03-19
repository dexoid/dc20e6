#!/bin/bash
install_packets() {
  local check=$(whereis salt-ssh | awk '{ print $2 }')
  if [ ! -f /etc/yum.repos.d/salt-latest.repo ]; then
    yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm
  fi
  if [ -z "$check" ]; then
    yum -y install salt-ssh
  fi
}

write_roster() {
  local hostname=${1}
  local ip=${2}
  cat<<EOF >>/etc/salt/roster
${hostname}:
  host: ${ip}
  user: root
EOF
}

check_host_exists() {
  local hostname=${1}
  local rosters=$(salt-ssh -H)
  if [ -z "$(echo "${rosters}" |grep -E "\s+${hostname}:")" ]; then
    return 1
  else
    return 0
  fi
}

main() {
  local hostname=${1}
  local ip=${2}
  install_packets
  if ! check_host_exists ${hostname} ${ip}; then
    write_roster ${hostname} ${ip}
    echo "Please instert this public key to remote host in /root/.ssh/authorized_keys"
    cat /etc/salt/pki/master/ssh/salt-ssh.rsa.pub
    echo "Then run 'vagrant provision' again"
  else
    cp /tmp/master /etc/salt/master
    salt-ssh -i ${hostname} state.highstate
  fi
}

main "$@"
