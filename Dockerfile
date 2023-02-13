FROM docker:23.0.1-dind

COPY docker-entrypoint.sh /

RUN apk add gitlab-runner && \
    chmod +x /docker-entrypoint.sh

VOLUME /etc/gitlab-runner /root/.docker

ENTRYPOINT ["/docker-entrypoint.sh"]
