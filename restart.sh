#!/bin/sh
[ out.mp4 ] && mv out.mp4 /opt/who-is-in/`date +%F-%H`.mp4
kill `ps ax | grep '[w]ho-is-in.rb' | awk '{print $1}'`
./who-is-in.rb --headless &
