# use ubuntu 20.04
FROM ubuntu:20.04

ARG GitHubUserName
ARG LoginUser="test"

# install packages
# openssh-server is necessary to emulate systemd.
RUN apt update && apt install -y openssh-server python3 sudo vim less
# this directory is needed to runing sshd
RUN mkdir -p /var/run/sshd

# add ansible excution user
RUN useradd -m -s /bin/bash $LoginUser && echo "$LoginUser:password" | chpasswd && gpasswd -a $LoginUser sudo

# copy sshd config file
COPY ./config_files/sshd_config /etc/ssh/sshd_config

# import ssh public key from github
RUN ssh-import-id-gh $GitHubUserName \
&& mkdir /home/$LoginUser/.ssh \
&& cp /root/.ssh/authorized_keys /home/$LoginUser/.ssh/ \
&& chmod 700 /home/$LoginUser/.ssh \
&& chmod 600 /home/$LoginUser/.ssh/authorized_keys \
&& chown -R $LoginUser /home/$LoginUser/.ssh \
&& chgrp -R $LoginUser /home/$LoginUser/.ssh

# open port 22
EXPOSE 22

# will excuted when `docker run`.
# This is necessary to emulate systemd.
ENTRYPOINT ["/sbin/init"]
