FROM 5200710/ubuntu:18.04-sdk

SHELL ["/bin/bash", "-c"]

RUN sdk install spark && ln -s /root/.sdkman/candidates/spark/current spark