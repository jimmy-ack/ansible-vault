FROM debian:stable-slim

# Debian packages installation
RUN apt update
RUN apt-get -y install wget git python3 python3-pip gnupg software-properties-common

# Installing virtualenv for python and ansible projects
# TODO

# Installing last terraform version
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update
RUN apt install terraform