FROM ubuntu:22.04

# install openssh-server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# TODO: set root's password, please modify it
RUN echo 'root:rootpassword' | chpasswd

# allow root to access through ssh
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# allow password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# open 22 port
EXPOSE 22

# start ssh service
CMD ["/usr/sbin/sshd", "-D"]

# after you put this Dockerfile somewhere
# build the docker file
#   docker build -t ubuntu-ssh .

# map host port 7777 to port 22, name it
#   docker run -d -p 7777:22 --name qumu ubuntu-ssh

