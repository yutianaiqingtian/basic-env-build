#!/bin/bash

cur_dir=$(pwd)
# login in shell folder
cd $(dirname "$0")
# SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
# echo $SHELL_FOLDER

docker build -t 5200710/hadoop:3.2.1 .

# go back
cd ${cur_dir}
