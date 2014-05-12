#!/bin/sh

## You'll need to replace alsa_output.pci..... to match your card.
## To find your card's name, type "pactl list". Search for the Source sections
## until you find an output source. You'll probably want to avoid "hdmi" sources
## if you are on a laptop.
avconv \
        -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -acodec libmp3lame \
        -threads 2 $1

