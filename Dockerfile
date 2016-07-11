FROM ruby:2.3.1-onbuild

ENV PORT 80
ENV PUMA_THREADS 0:30
ENV RACK_ENV production

RUN addgroup --gid 1000 protonet && \
    adduser --gecos "" --disabled-password --gid 1000 protonet && \
    mkdir -p /home/protonet/dashboard/shared/files/ && \
    mkdir -p /home/protonet/dashboard/shared/public/ && \
    mkdir -p /home/protonet/dashboard/shared/samba_includes/ && \
    mkdir -p /home/protonet/dashboard/shared/trash/ && \
    mkdir -p /home/protonet/dashboard/shared/uploads/ && \
    mkdir -p /home/protonet/dashboard/shared/log/ && \
    chown -R protonet:protonet /home/protonet

ENTRYPOINT ["./entrypoint.sh"]