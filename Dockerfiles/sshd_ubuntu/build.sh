#!/bin/bash

# auto read id_rsa.pub if exist
[[ -r ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub > ./authorized_keys

docker build -t sshd_ubuntu:0.0.1 .