#!/bin/sh
./reverse.rb images reverse 2>> log/who-is-in.log
ffmpeg -y -f image2 -i reverse/%04d.jpg -an out.mp4 2>> log/who-is-in.log

