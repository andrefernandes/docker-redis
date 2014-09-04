# CentOS 7 + Redis

FROM andrefernandes/docker-centos7-base

MAINTAINER Andre Fernandes

RUN yum install redis sudo -y && \
    yum clean all

RUN sed 's/daemonize yes/daemonize no/' -i /etc/redis.conf && \
    sed 's/bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis.conf && \
    sed '/^logfile/d' -i /etc/redis.conf && \
    sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers


ADD start /start
RUN chmod 755 /start

ENV MAXCLIENTS 2000
EXPOSE 6379
VOLUME ["/var/lib/redis"]
CMD ["/start"]

