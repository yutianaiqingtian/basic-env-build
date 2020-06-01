#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

# Install custom python package if requirements.txt is present
[ -e "/requirements.txt" ] && ${command-v pip3} install --user -r /requirements.txt

# check if support login with password
if [ ${ROOT_PASSWORD} ]; then
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# generate the publishkey and privatekey for passwordless login
[ ! -e ~/.ssh/id_rsa ] && ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >~/.ssh/authorized_keys
# deamon start sshd service
/usr/sbin/sshd -D &

# 指定一个Slave和Java变量
echo "localhost" >${SPARK_HOME}/conf/slaves
echo "JAVA_HOME=${JAVA_HOME}" >${SPARK_HOME}/conf/spark-env.sh

${SPARK_HOME}/sbin/start-all.sh

if [[ $1 == "-d" ]]; then
    tail -f ${SPARK_HOME}/logs/*.out
    # while true; do sleep 1000; done
fi

exec "$@"
