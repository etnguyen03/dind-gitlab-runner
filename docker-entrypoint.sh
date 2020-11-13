#!/bin/sh

DOCKER_HOST="/var/run/docker.sock"
containerd &> /var/log/containerd.log &
dockerd -H unix:///var/run/docker.sock &> /var/log/dockerd.log &
gitlab-runner run

