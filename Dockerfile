# use ubuntu 20.04
FROM ubuntu:20.04

# install packages
# openssh-server is necessary to emulate systemd.
RUN apt update && apt install -y openssh-server python3 sudo vim less
# this directory is needed to runing sshd
RUN mkdir -p /var/run/sshd

# add ansible excution user
RUN useradd -m -s /bin/bash test && echo "test:password" | chpasswd && gpasswd -a test sudo

# copy sshd config file
COPY ./config_files/sshd_config /etc/ssh/sshd_config

# import ssh public key from github
# write github user name
#RUN ssh-import-id-gh <YOUR-GITHUB-ACCOUNT-NAME>
RUN ssh-import-id-gh yassi-github \
&& mkdir /home/test/.ssh \
&& cp /root/.ssh/authorized_keys /home/test/.ssh/ \
&& chmod 700 /home/test/.ssh \
&& chmod 600 /home/test/.ssh/authorized_keys \
&& chown -R test /home/test/.ssh \
&& chgrp -R test /home/test/.ssh

# open port 22
EXPOSE 22

# will excuted when `docker run`.
# This is necessary to emulate systemd.
ENTRYPOINT ["/sbin/init"]

##############################################
### DON'T forget to white github user name!###
##############################################

