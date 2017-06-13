#!/bin/sh
exec /usr/bin/ffmpeg \
     -f v4l2 -s 640x360 -r 5 -input_format mjpeg -i /dev/video0 \
     -f mjpeg -qscale 5 - 2>/dev/null | /usr/local/bin/streameye -p 8888