#!/bin/sh

socat tcp-listen:$CHROMIUM_REMOTE_DEBUGGING_PORT,fork tcp:localhost:9220 &
chrome --no-sandbox --headless --disable-gpu --remote-debugging-port=9220
