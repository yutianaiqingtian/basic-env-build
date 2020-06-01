#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

# Install custom python package if requirements.txt is present
[ -e "/requirements.txt" ] && ${command-v pip3} install --user -r /requirements.txt

if [[ ${START_SSH_SERVICE} != "false" ]]; then
    # if ssh command not exist, then install sshd and depenency
    # command -v ssh || apk add --no-cache openrc openssh && rc-update add sshd
    command -v ssh || apk add --no-cache openssh
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
    mkdir -p /root/.ssh && chmod 700 /root/.ssh/
    ssh-keygen -A
    echo "root:${USER_PASSWORD:=admin}" | chpasswd
    # generate the publishkey and privatekey for passwordless login
    [ ! -e ~/.ssh/id_rsa ] && ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >~/.ssh/authorized_keys
    # touch /run/openrc/softlevel && /etc/init.d/sshd restart
    # service sshd restart
    /usr/sbin/sshd -D &
fi

apk --no-cache add procps coreutils

# 指定一个Slave和Java变量
echo "localhost" >${SPARK_HOME}/conf/slaves
echo "JAVA_HOME=${JAVA_HOME}" >${SPARK_HOME}/conf/spark-env.sh

${SPARK_HOME}/sbin/start-all.sh

if [[ $1 == "-d" ]]; then
    tail -f ${SPARK_HOME}/logs/*.out
    # while true; do sleep 1000; done
fi

exec "$@"
