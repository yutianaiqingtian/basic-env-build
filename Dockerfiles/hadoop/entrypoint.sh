#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

if [ ! -e /home/hadoop/.ssh/authorized_keys ]; then
    su - hadoop -c '/usr/bin/ssh-keygen -t rsa -P "" -f /home/hadoop/.ssh/id_rsa'
    su - hadoop -c 'cat /home/hadoop/.ssh/id_rsa.pub > /home/hadoop/.ssh/authorized_keys'
    chmod 0600 /home/hadoop/.ssh/authorized_keys
fi

service ssh start

su - hadoop -c '/home/hadoop/sbin/start-all.sh'

if [[ $1 == "-d" ]]; then
    tail -f /home/hadoop/logs/*
    # while true; do sleep 1000; done
else
    /bin/bash
fi