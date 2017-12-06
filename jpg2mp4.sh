#!/bin/sh
ffmpeg -y -f image2 -i images/%04d.jpg -an out.mp4 2>> log/who-is-in.log
