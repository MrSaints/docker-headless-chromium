# docker-headless-chromium

A lightweight Docker image for headless Chromium, with remote debugging support.

It is built on `debian:stable-slim`.


## Install

```
docker pull mrsaints/headless-chromium
```


## Usage

```
docker run --privileged -it --rm -p 9222:9222 mrsaints/headless-chromium
```

Now, visit [http://localhost:9222](http://localhost:9222).


## Caveats

Chromium's remote debugging protocol API binds to `localhost`.
Consequently, the API is not accessible outside of the Docker container.
`socat` is hence used (see [`run.sh`](run.sh)) to proxy traffic from the outside world (non-localhost) to the API.
