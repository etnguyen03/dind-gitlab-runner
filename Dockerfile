FROM docker:20.10.18-dind

COPY docker-entrypoint.sh /

RUN apk add gitlab-runner && \
    chmod +x /docker-entrypoint.sh

VOLUME /etc/gitlab-runner /root/.docker

ENTRYPOINT ["/docker-entrypoint.sh"]
