#!/bin/bash

#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

# Install custom python package if requirements.txt is present
[ -e "/requirements.txt" ] && ${command-v pip3} install --user -r /requirements.txt

echo "print ${START_SSH_SERVICE}"
# check if need to start ssh service
if [[ ${START_SSH_SERVICE} == "true" ]]; then
    # if ssh command not exist, then install sshd and depenency
    command -v ssh || apk add --no-cache openssh
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
    mkdir -p /root/.ssh && chmod 700 /root/.ssh/
    ssh-keygen -A
    echo "root:${USER_PASSWORD:=admin}" | chpasswd
    # generate the publishkey and privatekey for passwordless login
    [ ! -e ~/.ssh/id_rsa ] && ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub >~/.ssh/authorized_keys
    /usr/sbin/sshd -D &
fi

export SPARK_MASTER_HOST=$(hostname)

. /spark/sbin/spark-config.sh
. /spark/bin/load-spark-env.sh

[ ! -d $SPARK_MASTER_LOG ] && mkdir -p $SPARK_MASTER_LOG

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >>$SPARK_MASTER_LOG/spark-master.out
