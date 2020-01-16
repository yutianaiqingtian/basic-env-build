FROM openjdk:8

ARG HADOOP_VERSION=3.2.1

RUN apt-get update && apt-get install -y openssh-server

# start sshd service
RUN /etc/init.d/ssh start   
# create a user and use it
RUN groupadd -r hadoop && useradd -r -g hadoop -m hadoop
USER hadoop

# Install Hadoop
RUN curl -L -S \
      http://mirror-hk.koddos.net/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
      -o /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar xzf /tmp/hadoop-${HADOOP_VERSION}.tar.gz --strip-components 1 -C ~/ \
    && rm -rf /tmp/hadoop-${HADOOP_VERSION}.tar.gz

# Configuration Changes
COPY etc/hadoop/*.xml ~/etc/hadoop/

# Configure SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

# Format HDFS
RUN ~/bin/hdfs namenode -format

# # Alias to start and stop Hadoop Daemons
# RUN echo 'alias hstart="/opt/hadoop/sbin/start-all.sh"' >> ~/.bash_profile \
#     && echo 'alias hstop="/opt/hadoop/sbin/stop-all.sh"' >> ~/.bash_profile \
#     && source ~/.bash_profile

# Access Hadoop web interface by connecting to
# Resource Manager: http://localhost:9870
# JobTracker: http://localhost:8088/
# Node Specific Info: http://localhost:8042/
EXPOSE 9870 8088 8042

CMD ["~/sbin/start-all.sh"]