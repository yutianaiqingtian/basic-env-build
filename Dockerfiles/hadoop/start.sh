#!/bin/bash

chown -R hadoop:hadoop /home/hadoop

service ssh start && su hadoop \
&& ssh-keygen -t rsa -P '' -f /home/hadoop/.ssh/id_rsa \
&& cat /home/hadoop/.ssh/id_rsa.pub > /home/hadoop/.ssh/authorized_keys \
&& chmod 0600 /home/hadoop/.ssh/authorized_keys

# Format HDFS
/home/hadoop/bin/hdfs namenode -format

/home/hadoop/sbin/start-all.sh