#! /bin/bash

TOPXY="0,0"
INRES="1366x768"

if (test $? -gt 2) then
  TOPXY="$1,$2"
  if (test $? -eq 5) then
    INRES="$3x$4"
  fi
fi

OUTRES="1280x720"
FPS="25"
QUAL=6 #number 1 - 31, lower the more quality

#DATE=`date +%Y%m%d`
DATE=`date +%F_%I:%M:%S`

avconv \
	-f pulse -ac 2 -i alsa_output.pci-0000_00_14.2.analog-stereo.monitor -acodec mp3 \
	-f x11grab -s $INRES -video_size $OUTRES -r $FPS -i :0.0 \
	-threads 2 -q $QUAL \
	-vcodec flv -s $OUTRES -ar 11025 -bt 11025 -b 11025 \
	$DATE".flv"

#	-f alsa -ac 2 -i pulse \



