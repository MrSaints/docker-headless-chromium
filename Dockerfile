FROM debian:stable-slim

LABEL org.label-schema.vcs-url="https://www.github.com/MrSaints/docker-chromium-headless" \
      maintainer="Ian L. <os@fyianlai.com>"

ARG CHROMIUM_REVISION=475520
ARG CHROMIUM_REMOTE_DEBUGGING_PORT=9222

ENV CHROMIUM_REMOTE_DEBUGGING_PORT=$CHROMIUM_REMOTE_DEBUGGING_PORT

RUN apt-get update \
    && apt-get install -y curl nano socat unzip wget \
    && apt-get install -y \
    libasound2 \
    libgconf-2-4 \
    libgtk-3-0 \
    libnss3 \
    libosmesa6 \
    libX11-xcb-dev \
    libxss1

RUN wget -O chromium.zip https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$CHROMIUM_REVISION%2Fchrome-linux.zip?alt=media \
    && unzip chromium.zip \
    && rm chromium.zip \
    && mv /chrome-linux/ /chromium/ \
    && cp /usr/lib/x86_64-linux-gnu/libOSMesa.so.6 /chromium/libosmesa.so

COPY run.sh run.sh

ENV PATH="/chromium/:${PATH}"

RUN chrome --version

HEALTHCHECK --interval=1m --timeout=10s \
  CMD curl -f http://localhost:$CHROMIUM_REMOTE_DEBUGGING_PORT || exit 1

EXPOSE 9222

CMD "./run.sh"
