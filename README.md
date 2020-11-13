# dind-gitlab-runner

Runs a Gitlab Runner instance, along with all the necessary stuff to run Docker
containers, all inside a Docker container.

**IMPORTANT**: Read the security warnings below before you try this.

## Quick start

Change directory into a directory that you can use for volumes. In the example
below, the subdirectories `gitlab-runner` and `docker` are used for saving the
`gitlab-runner` and the `docker` authentication credentials, respectively.

Therefore, these directories should only be readable by `root`.

Or, just omit the two `-v` options because the Dockerfile specifies that these two
directories can be used as volumes.

For Docker in Docker to work, you will need the `--privileged` flag.

```bash
docker run -d --restart=unless-stopped --name=gitlab-runner -v $PWD/gitlab-runner:/etc/gitlab-runner -v $PWD/docker:/root/.docker --privileged dind-gitlab-runner
```

Then, you will need to

```bash
docker exec -it gitlab-runner /bin/sh
```

to get a shell within the container so that you can configure it.

Within this shell, run

```bash
gitlab-runner register
```

to register the runner. When requested, enter `docker` for [the executor](https://docs.gitlab.com/runner/executors/README.html). Then, run

```bash
docker login
```

to log into Docker Hub. (If you won't be using Docker Hub, then you
can probably omit this. However, you probably are.)

Then, run `exit` to exit the shell.

The runner is now ready for use.

## Security warning

Your Docker credentials are stored in plain text, and so is your Gitlab Runner token.

Docker-in-Docker is subject to privilege execution since you are using `--privileged`.
I'd only run this on a personal, properly firewalled and secured Gitlab instance.
But I don't know, you do you. Don't come after me if you get hacked. (See the GPL.)

---

Copyright © 2020 Ethan Nguyen

This program is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see https://www.gnu.org/licenses/.
