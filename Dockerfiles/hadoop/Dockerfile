FROM 5200710/ubuntu:18.04-163

ARG HADOOP_VERSION=3.2.1

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# install ssh client and server
RUN softwares='curl openjdk-8-jdk openssh-client openssh-server' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

RUN useradd -r -m -U hadoop

# Install Hadoop
RUN curl -L -S \
    http://mirror-hk.koddos.net/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz --strip-components 1 -C /home/hadoop \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

# Configuration Changes
RUN sed -i 's/# export JAVA_HOME=/export JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-amd64/g' /home/hadoop/etc/hadoop/hadoop-env.sh
COPY etc/hadoop/*.xml /home/hadoop/etc/hadoop/

RUN chown -R hadoop:hadoop /home/hadoop && su - hadoop -c '/home/hadoop/bin/hdfs namenode -format'

COPY entrypoint.sh /entrypoint.sh

# Access Hadoop web interface by connecting to
# Resource Manager: http://localhost:9870
# JobTracker: http://localhost:8088/
# Node Specific Info: http://localhost:8042/
EXPOSE 9870 8088 8042

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-d" ]