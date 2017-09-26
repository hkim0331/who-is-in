#!/bin/sh
ffmpeg -f image2 -i images/%04d.jpg -framerate 1 out.mp4

