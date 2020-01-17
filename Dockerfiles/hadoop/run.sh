#!/bin/bash

service ssh start && su hadoop

# Configure SSH
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
&& chmod 0600 ~/.ssh/authorized_keys

# Format HDFS
~/bin/hdfs namenode -format

~/sbin/start-all.sh