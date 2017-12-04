#!/bin/sh
ffmpeg -y -f image2 -i images/%04d.jpg -an -vf "setpts=10.0*PTS"  out.mp4
