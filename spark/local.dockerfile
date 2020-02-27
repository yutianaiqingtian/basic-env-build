FROM ubuntu:18.04

RUN softwares='curl zip unzip' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

SHELL ["/bin/bash", "-c"]
# install sdkman tools kits and spark
RUN curl -s "https://get.sdkman.io" | bash \
    && source "/root/.sdkman/bin/sdkman-init.sh" \
    && rm -rf /root/.sdkman/tmp/* \
    && sdk install java 8.0.242.hs-adpt \
    && sdk install scala 2.12.10 \
    && sdk install spark 2.4.4 \
    && ln -s /root/.sdkman/candidates/spark/current /opt/spark