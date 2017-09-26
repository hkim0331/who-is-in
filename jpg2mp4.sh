#!/bin/sh
ffmpeg -f image2 -i images/%d.jpg -framerate 1 out.mp4

