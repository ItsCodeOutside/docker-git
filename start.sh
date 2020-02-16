#!/bin/sh

# Checking permissions and fixing SGID bit in repos folder
# More info: https://github.com/jkarlosb/git-server-docker/issues/1
if [ "$(ls -A /git-server/repos/)" ]; then
  cd /git-server/repos
  chown -R git:git .
  chmod -R ug+rwX .
  find . -type d -exec chmod g+s '{}' +
fi

# Generate new host key if it doesn't already exist
if [ !"$(ls -A /etc/ssh/*_key)" ]; then
  ssh-keygen -A
fi

# -D flag avoids executing sshd as a daemon
if [ -n "${DEBUG}" ]; then
  /usr/sbin/sshd -D -ddd
else
  /usr/sbin/sshd -D
fi
