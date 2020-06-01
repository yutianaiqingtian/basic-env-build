FROM 5200710/spark:spark-base-2.4.5

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_WEBUI_PORT 8081

RUN apk --no-cache add procps coreutils

EXPOSE 8080 7077 6066

ENV PYSPARK_PYTHON python3

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-d" ]