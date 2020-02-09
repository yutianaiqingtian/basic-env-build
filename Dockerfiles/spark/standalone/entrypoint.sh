#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

if [ ! -e ~/.ssh/authorized_keys ]; then
    /usr/bin/ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    chmod 0600 ~/.ssh/authorized_keys
fi

service ssh start

# 指定一个Slave和Java变量
echo "localhost" > /opt/spark/conf/slaves
echo "JAVA_HOME=/root/.sdkman/candidates/java/current" > /opt/spark/conf/spark-env.sh

/opt/spark/sbin/start-all.sh

if [[ $1 == "-d" ]]; then
    tail -f /opt/spark/logs/*.out
    # while true; do sleep 1000; done
fi

exec "$@"