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
FPS="8"
QUAL=11 #number 1 - 31, lower the more quality

#DATE=`date +%Y%m%d`
DATE=`date +%F_%I:%M:%S`

avconv \
	-f x11grab -show_region 1 -s $INRES -video_size $OUTRES -framerate $FPS -i :0.0+$TOPXY \
	-threads 2 -q $QUAL \
	-vcodec flv -s $OUTRES -bt 400 -b 1200 \
	-f flv $DATE".flv"

#	-f alsa -ac 2 -i pulse \



