FROM alpine:latest
MAINTAINER MoonChang Chae <mcchae@gmail.com>

RUN apk add --update tzdata openssh bash netcat-openbsd \
    util-linux dbus ttf-freefont xauth xf86-input-keyboard sudo \
    && cp -f /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone \
    && mkdir -p ~root/.ssh && chmod 700 ~root/.ssh \
    && rm  -rf /tmp/* /var/cache/apk/*

RUN addgroup toor \
    && adduser  -G toor -s /bin/sh -D toor \
    && echo "toor:r" | /usr/sbin/chpasswd \
    && echo "toor    ALL=(ALL) ALL" >> /etc/sudoers

ADD chroot /
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
