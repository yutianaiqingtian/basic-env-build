#!/bin/bash

set -e

docker build -t 5200710/spark:spark-base-2.4.5 -f ./base/base.dockerfile ./base
docker build -t 5200710/spark:spark-master-2.4.5 -f ./spark-master/spark-master.dockerfile ./spark-master
docker build -t 5200710/spark:spark-worker-2.4.5 -f ./spark-worker/spark-worker.dockerfile ./spark-worker
