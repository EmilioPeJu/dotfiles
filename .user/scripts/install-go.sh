#!/bin/bash
VER=1.14.3
ARCH=linux-amd64
FILE=go${VER}.${ARCH}.tar.gz
cd /tmp
wget https://dl.google.com/go/${FILE}
tar xvfz ${FILE}
mkdir -p ~/.go
mv go ~/.golang
