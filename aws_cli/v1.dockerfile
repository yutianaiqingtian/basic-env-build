FROM python:2.7.18-alpine3.10

RUN apk -Uuv add groff less && rm /var/cache/apk/*
RUN pip --no-cache-dir install -U awscli aws_role_credentials oktaauth