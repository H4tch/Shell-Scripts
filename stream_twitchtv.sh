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
#OUTRES="640x360"
#"854x480"
#"996x560"
#"1067x600"
#"1138x640"
FPS="8"
#QUAL="fast"
QUAL=11 #number 1 - 31, lower the more quality

STREAM_KEY=$(cat ~/.ssh/twitch_key)
   
avconv \
	-f x11grab -show_region 1 -s $INRES -video_size $OUTRES -framerate $FPS -i :0.0+$TOPXY \
	-threads 2 -q $QUAL \
	-vcodec flv -s $OUTRES -bt 400 -b 1200 \
	-f flv "rtmp://live.justin.tv/app/$STREAM_KEY"
#	-f flv "test.flv"

#	-f alsa -ac 2 -i pulse \
#	-acodec mp2 -ar 44100 -threads 2 -qscale 3 -b 712000 -bufsize 512k \



