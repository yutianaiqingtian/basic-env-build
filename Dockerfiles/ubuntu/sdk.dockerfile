FROM 5200710/ubuntu:18.04-163

RUN softwares='curl zip unzip' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

# install sdkman tools kits
RUN curl -s "https://get.sdkman.io" | bash \
    && source "/root/.sdkman/bin/sdkman-init.sh" \
    && rm -rf /root/.sdkman/tmp/*