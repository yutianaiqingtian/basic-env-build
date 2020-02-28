FROM 5200710/hadoop:2.7.7-base

ENV HODOOP_HOME=/home/hadoop

COPY start-master.sh ${HODOOP_HOME}/

EXPOSE 50070

CMD "${HODOOP_HOME}/start-master.sh"