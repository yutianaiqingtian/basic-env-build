FROM ubuntu:18.04

# ARG DEFAULT_APT=http://archive.ubuntu.com/ubuntu/
# ARG ALIYUN_APT=http://mirrors.aliyun.com/ubuntu/
# ARG USTC_APT=https://mirrors.ustc.edu.cn/ubuntu/
# ARG 163_APT=http://mirrors.163.com/ubuntu/
# ARG TUNA_APT=https://mirrors.tuna.tsinghua.edu.cn/ubuntu/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \
    && sed -ir '/^#.*/d' /etc/apt/sources.list \
    && sed -i '12,$d' /etc/apt/sources.list \
    && sed -r 's/^deb http:\/\/archive\.ubuntu\.com\/ubuntu(.*)/deb http:\/\/mirrors.163.com\/ubuntu\1/g' /etc/apt/sources.list > /etc/apt/sources.list.tmp \
    && mv /etc/apt/sources.list.tmp /etc/apt/sources.list \
    && apt-get update
