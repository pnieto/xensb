# pnietoiglesias/xensb/Dockerfile
#
# VERSION    0.1
#

FROM ubuntu:14.04

RUN apt-get update && \
    apt-get -y install python-virtualenv \
    openssh-client \
    git \
    sqlite \
    emacs24-nox

RUN pip install flask
EXPOSE 5000