FROM --platform=linux/i386 docker.io/i386/alpine:3.17
# Install required packages

RUN echo -e "\n@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add --no-cache alpine-base bash
# Setup the init script
RUN apk add --no-cache openrc udev xorg-server lightdm i3 font-dejavu xrandr bash
# Add a user
RUN adduser -D -s /bin/bash user && echo 'user:password' | chpasswd
# Allow root login
RUN echo 'root:password' | chpasswd
# Configure lightdm to start i3
RUN sed -i "s/#autologin-user=/autologin-user=user/g" /etc/lightdm/lightdm.conf && sed -i "s/#autologin-user-timeout=0/autologin-user-timeout=0/g" /etc/lightdm/lightdm.conf && sed -i "s/#autologin-session=/autologin-session=i3/g" /etc/lightdm/lightdm.conf

# terminal apps
RUN apk add --no-cache vim python3 nano openssh
# gui apps
RUN apk add --no-cache gedit xterm thunar

CMD [ "/bin/sh" ]
