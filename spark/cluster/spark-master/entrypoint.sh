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
    # command -v ssh || apk add --no-cache openrc openssh && rc-update add sshd
    command -v ssh || apk add --no-cache openssh
    [ ! -e /etc/ssh/ssh_host_rsa_key ] && ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key
    [ ! -e /etc/ssh/ssh_host_ed25519_key ] && ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key
    [ ! -e /etc/ssh/ssh_host_ecdsa_key ] && ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_ecdsa_key
    # touch /run/openrc/softlevel && /etc/init.d/sshd restart
    # service sshd restart
    /usr/sbin/sshd -D &
fi

export SPARK_MASTER_HOST=$(hostname)

. /spark/sbin/spark-config.sh
. /spark/bin/load-spark-env.sh

[ ! -d $SPARK_MASTER_LOG ] && mkdir -p $SPARK_MASTER_LOG

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >>$SPARK_MASTER_LOG/spark-master.out
