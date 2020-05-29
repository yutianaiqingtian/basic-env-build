#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

# Install custom python package if requirements.txt is present
if [ -e "/requirements.txt" ]; then
    ${command -v pip3} install --user -r /requirements.txt
fi

if [ -e ${command -v python} ]; then
    ln -s ${command -v python3} /usr/bin/python
fi

[ -z $JAVA_HOME ] && JAVA_HOME='/root/.sdkman/candidates/java/current'
[ -z $SPARK_HOME ] && SPARK_HOME='/root/.sdkman/candidates/spark/current'

if [ ! -e ~/.ssh/authorized_keys ]; then
    /usr/bin/ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >~/.ssh/authorized_keys
    chmod 0600 ~/.ssh/authorized_keys
fi

service ssh start

# 指定一个Slave和Java变量
echo "localhost" >${SPARK_HOME}/conf/slaves
echo "JAVA_HOME=${JAVA_HOME}" >${SPARK_HOME}/conf/spark-env.sh

${SPARK_HOME}/sbin/start-all.sh

if [[ $1 == "-d" ]]; then
    tail -f ${SPARK_HOME}/logs/*.out
    # while true; do sleep 1000; done
fi

exec "$@"
