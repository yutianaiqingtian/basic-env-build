FROM ubuntu:18.04

RUN softwares='curl zip unzip' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

SHELL ["/bin/bash", "-c"]
# install sdkman tools kits and spark
RUN curl -s "https://get.sdkman.io" | bash \
    && source "/root/.sdkman/bin/sdkman-init.sh" \
    && rm -rf /root/.sdkman/tmp/* \
    && sdk install spark \
    && ln -s /root/.sdkman/candidates/spark/current spark