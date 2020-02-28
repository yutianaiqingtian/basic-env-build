#!/bin/bash

cur_dir=$(pwd)
# login in shell folder
cd $(dirname "$0")
# SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
# echo $SHELL_FOLDER

docker build -t 5200710/hadoop:2.7.7-master .

# go back
cd ${cur_dir}
