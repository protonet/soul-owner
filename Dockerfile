FROM ruby:2.3.1-onbuild

ENV PORT 80
ENV PUMA_THREADS 0:30

ENTRYPOINT ["./entrypoint.sh"]