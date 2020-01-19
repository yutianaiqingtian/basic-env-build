#!/bin/bash

cur_dir=$(pwd)
# login in shell folder
cd $(dirname "$0")
# SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
# echo $SHELL_FOLDER

docker build -t 5200710/alpine:3.11.3 .

# go back
cd ${cur_dir}
