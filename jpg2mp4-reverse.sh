#!/bin/sh
./reverse.rb images reverse
ffmpeg -y -f image2 -i reverse/%04d.jpg -an -vf "setpts=5.0*PTS"  out.mp4
