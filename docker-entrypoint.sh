#!/bin/sh

DOCKER_HOST="/var/run/docker.sock"

# Ensure that Docker's pidfile does not exist
[ -f /var/run/docker.pid ] && rm /var/run/docker.pid

containerd &> /var/log/containerd.log &
dockerd -H unix:///var/run/docker.sock &> /var/log/dockerd.log &
gitlab-runner run

