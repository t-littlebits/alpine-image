FROM --platform=linux/i386 docker.io/i386/debian:buster
ARG DEBIAN_FRONTEND=noninteractive

# Point APT to the archived mirrors (Buster is EOL)
RUN echo "deb [trusted=yes] http://archive.debian.org/debian buster main contrib non-free" \
  > /etc/apt/sources.list && \
  echo "deb [trusted=yes] http://archive.debian.org/debian-security buster/updates main" \
  >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install xorg lightdm i3 xterm gedit

# Add a user
RUN useradd -m -s /bin/bash user && echo 'user:password' | chpasswd
# Allow root login
RUN echo 'root:password' | chpasswd

# Configure lightdm to start i3
RUN sed -i "s/#autologin-user=/autologin-user=user/g" /etc/lightdm/lightdm.conf && \
    sed -i "s/#autologin-session=/autologin-session=i3/g" /etc/lightdm/lightdm.conf

CMD [ "/bin/sh" ]
