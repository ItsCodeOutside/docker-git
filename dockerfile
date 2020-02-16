FROM alpine:latest

MAINTAINER ItsCodeOutside https://github.com/ItsCodeOutside
#https://github.com/jkarlosb/git-server-docker/blob/master/Dockerfile

WORKDIR /git-server/
EXPOSE 22
COPY git-shell-commands /home/git/git-shell-commands
COPY start.sh start.sh
COPY updateKeys.sh updateKeys.sh

RUN apk add --no-cache \
  openssh \
  git \
  && mkdir /git-server/keys \
  && adduser -D -s /usr/bin/git-shell git \
# Generate random string for password https://gist.github.com/earthgecko/3089509
  && echo git:$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) | chpasswd \
  && mkdir /home/git/.ssh \
  && > /etc/motd \
  && chown -R git:git /home/git/* \
  && chmod -R 500 /home/git/git-shell-commands \
  && chown root:root /git-server/updateKeys.sh \
  && chmod 500 /git-server/updateKeys.sh

COPY sshd_config /etc/ssh/sshd_config

CMD  sh start.sh
