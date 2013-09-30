#!/bin/sh

avconv \
        -f pulse -ac 2 -i alsa_output.pci-0000_00_14.2.analog-stereo.monitor -acodec libmp3lame \
        -threads 2 $1

