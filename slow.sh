#!/bin/sh

ffmpeg -i out.mp4 -vf setpts=20*PTS slow.mp4
