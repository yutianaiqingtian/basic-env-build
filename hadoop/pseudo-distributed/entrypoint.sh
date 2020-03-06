#!/usr/bin/env bash

#!/bin/bash

# Set some sensible defaults
export CORE_CONF_fs_defaultFS=${CORE_CONF_fs_defaultFS:-hdfs://`hostname -f`:8020}

function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}

addProperty /etc/hadoop/core-site.xml fs.defaultFS ${CORE_CONF_fs_defaultFS}
addProperty /etc/hadoop/core-site.xml hadoop.tmp.dir ${HADOOP_HOME}/data
addProperty etc/hadoop/hdfs-site.xml dfs.replication 1

sed -i "s~#\ export\ JAVA_HOME=~export\ JAVA_HOME=$JAVA_HOME~g" /etc/hadoop/hadoop-env.sh

mkdir ${HADOOP_HOME}/logs
mkdir ${HADOOP_HOME}/data
chown -R hadoop:hadoop ${HADOOP_HOME}

service ssh start

su - hadoop <<EOF
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
${HADOOP_HOME}/bin/hdfs namenode -format
${HADOOP_HOME}/sbin/start-dfs.sh

EOF

# YARN on a Single Node

addProperty /etc/hadoop/mapred-site.xml mapreduce.framework.name yarn
addProperty /etc/hadoop/mapred-site.xml mapreduce.application.classpath $HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*
addProperty /etc/hadoop/yarn-site.xml yarn.nodemanager.aux-services mapreduce_shuffle
addProperty /etc/hadoop/yarn-site.xml yarn.nodemanager.env-whitelist JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_HOME

# start yarn
su - hadoop -c "${HADOOP_HOME}/sbin/start-yarn.sh"

if [[ $1 -eq '-d' ]]; then
  tail -f ${HADOOP_HOME}/logs/*
fi

exec $@
