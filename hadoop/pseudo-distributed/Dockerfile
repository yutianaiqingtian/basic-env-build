FROM 5200710/ubuntu:18.04-163

ARG HADOOP_VERSION=3.2.1

ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $HADOOP_HOME/bin/:$JAVA_HOME/bin/:$PATH

# install ssh client and server
RUN softwares='curl openjdk-8-jdk openssh-client openssh-server' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

# add a hadoop user
RUN useradd -r -m -U hadoop -s /bin/bash

# Install Hadoop
RUN curl -L -S \
    http://mirror-hk.koddos.net/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

# COPY hadoop-${HADOOP_VERSION}.tar.gz /tmp/
# RUN tar -xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
#     && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop \
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

COPY etc/hadoop/* /etc/hadoop/
RUN sed -i "s~#\ export\ JAVA_HOME=~export\ JAVA_HOME=$JAVA_HOME~g" /etc/hadoop/hadoop-env.sh

WORKDIR ${HADOOP_HOME}

RUN mkdir ./logs && mkdir ./data && chown -R hadoop:hadoop ./

USER hadoop
RUN ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys \
    && bin/hdfs namenode -format

USER root

COPY entrypoint.sh /entrypoint.sh

# the web interface for the NameNode
EXPOSE 9870
# the web interface for the ResourceManager
EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]