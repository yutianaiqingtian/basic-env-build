#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

service ssh start

ln -sf /dev/stdout $HADOOP_HOME/logs/hadoop-master.out

su - hadoop -c '/home/hadoop/sbin/start-all.sh' >>$HADOOP_HOME/logs/spark-master.out

if [[ $1 == "-d" ]]; then
    tail -f /home/hadoop/logs/*
    # while true; do sleep 1000; done
fi

exec "$@"
