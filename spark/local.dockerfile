FROM ubuntu:18.04

ENV SPARK_VERSION=2.4.4
ENV JAVA_VERSION=8.0.252-open
ENV SCALA_VERSION=2.12.10
RUN softwares='curl zip unzip' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# install sdkman tools kits and spark
RUN curl -s "https://get.sdkman.io" | bash \
    && source "/root/.sdkman/bin/sdkman-init.sh" \
    && sdk install java ${JAVA_VERSION} \
    && sdk install scala ${SCALA_VERSION} \
    && sdk install spark ${SPARK_VERSION} \
    && rm -rf $SDKMAN_DIR/archives/* $SDKMAN_DIR/tmp/*