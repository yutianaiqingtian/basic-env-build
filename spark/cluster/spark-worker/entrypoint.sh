#!/bin/bash

#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero exit status.
set -e

# Install custom python package if requirements.txt is present
[ -e "/requirements.txt" ] && ${command-v pip3} install --user -r /requirements.txt

. "/spark/sbin/spark-config.sh"
. "/spark/bin/load-spark-env.sh"

[ ! -d $SPARK_WORKER_LOG ] && mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >>$SPARK_WORKER_LOG/spark-worker.out
