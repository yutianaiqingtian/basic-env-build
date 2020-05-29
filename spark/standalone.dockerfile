FROM 5200710/spark:2.4.4-local

RUN softwares='openssh-server openssh-client python3.7 python3-pip' \
    && apt-get update && apt-get install -y $softwares \
    && rm -rf /var/lib/apt/lists/* 

ENV PYSPARK_PYTHON python3

COPY ./standalone/entrypoint.sh /entrypoint.sh

EXPOSE 8080 8081

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-d" ]