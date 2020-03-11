#!/usr/bin/env bash

service ssh start

# start dfs
su - hadoop -c "${HADOOP_HOME}/sbin/start-dfs.sh"

# start yarn
su - hadoop -c "${HADOOP_HOME}/sbin/start-yarn.sh"

if [[ -z "$1" ]]; then
  while true; do sleep 1000; done
  # tail -f "${HADOOP_HOME}/logs/*.log"
fi

if [[ "bash" == "$1" ]]; then
  su hadoop
fi

exec $@
