FROM 5200710/ubuntu:18.04-163

ENV HADOOP_VERSION=2.7.7
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/home/hadoop

# install ssh client and server
RUN softwares='curl openjdk-8-jdk openssh-client openssh-server' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

RUN useradd -r -m -U hadoop

# Install Hadoop
# RUN curl -L -S \
#     http://mirror-hk.koddos.net/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
#     -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
#     && tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz --strip-components 1 -C /home/hadoop \
#     && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

COPY ./hadoop-2.7.7.tar.gz /tmp/
RUN tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz --strip-components 1 -C /home/hadoop \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

# Configuration Changes
RUN echo "export JAVA_HOME=${JAVA_HOME}" >> /home/hadoop/etc/hadoop/hadoop-env.sh
COPY etc/hadoop/* /home/hadoop/etc/hadoop/

RUN chown -R hadoop:hadoop /home/hadoop && su - hadoop -c '/home/hadoop/bin/hdfs namenode -format'

COPY --chown=hadoop:hadoop .ssh/ /home/hadoop/