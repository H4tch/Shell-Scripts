#! /bin/bash
## 2013 by Dan Hatch danhatch333@gmail.com
## 
## Todo
##	Add target directory for both modes(timelapse and export).
##	Add encoding options for width and height.
##	Check return value from CheckDep before continuing execution.



# Helper function to Check for and Install the dep.
CheckDep()
{
	`$1 &> /dev/null`
	if (test $? -eq 127) then
		echo "Need to install $1."
		sudo apt-get install $1 -y
	fi
}


Kill () {
	killall $0
    killall timelapse.sh
	exit 0;
}

Killall () {
	killall mencoder
	killall $0
    killall timelapse.sh
	exit 0;
}



# Main function that takes the screenshots for the timelapse.
SnapShot ()
{
	# Take the snapshot
	scrot -q 90 $1/$(date +%F_%I:%M:%S).jpg;
   	
   	# Print the frame number to the console.
   	echo -n -e "\b\b\b\b\b\b\b\b"$i;
    let frame++;
}



Timelapse ()
{
	CheckDep scrot

	DATE=`date +%F`
	TIME=`date +%I:%M`

	DIR=`echo ~/Screencast`
	mkdir $DIR &> /dev/null
	DIR=$DIR/$DATE
	mkdir $DIR &> /dev/null
	DIR=$DIR/$TIME
	mkdir $DIR &> /dev/null

	echo "Starting Timelapse in 10 seconds."
	echo "	Saving the Screenshots to:/n$DIR"
	notify-send -t 10 -a Time-Lapse.sh -i clock "Starting Timelapse in 10 seconds" "Saving the Screenshots to:\n$DIR."

	sleep 12  # Added a couple of seconds to hide the notification

	# Show Today's Date for a while.
	# (noate Ubuntu forcefully shows notifications for 10 seconds.)
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"
	notify-send -t 10 -i calendar -a Time-Lapse.sh "$(date '+%B %m %Y')" "$(date '+%X')"

	frame="01"
	# Infinite Loop
	while [ 1 ];
	   	do SnapShot "$DIR"
		sleep 1;
	done
}



Encode ()
{
	CheckDep mencoder

	FPS="20"
	#QUAL=11
	if (test $# -eq 1) then
		#echo "Please pass in a directory/pattern to export, e.g. 'export ~/Screencast/2013-01-01/*.jpg'"
		exit 1;
	fi

	DATE=`date +%F`
	DIR=`echo ~/Screencast`

	EXT_VID="mpg"
	EXT_IMG="jpg"

	test -d $DIR
	if (test $? -eq 1) then
		echo "No Screencast folder exists."
	fi

	SCREENSHOTS=$DIR/$DATE
	test -d $SCREENSHOTS
	if (test $? -eq 1) then
		echo "No Screencast was recorded today."
	else
		echo "Found Screenshots in "$SCREENSHOTS
	fi

	FILE=$DIR/$DATE"."$EXT_VID
	test -f $FILE
	if (test $? -eq 0) then
		FILE_NUM=1
		echo "file exists,trying new name"
		while [ $FILE_NUM != 0 ];
			FILE=$DIR/$DATE"_"$FILE_NUM"."$EXT_VID
			`test -f $FILE`
			if (test $? -eq 0) then
				let FILE_NUM++
			else FILE_NUM=0; break;
			fi
			do test -f ;
		done
	fi

	notify-send -t 10 -i video -a Time-Lapse.sh "Exporting Timelapse" "$FILE"
	echo "Saving to file "$FILE"."


	mencoder -ovc x264 -mf w=1366:h=768:fps=20:type=$EXT_IMG 'mf://'$DIR'/'$DATE'/*/*.'$EXT_IMG -o $FILE


	#mencoder -ovc x264 -oac mp3lame -audiofile "" -mf w=1366:h=768:fps=$FPS:type=jpg 'mf://@files.txt' -o ~/Screencast/$DATE.avi
	#ffmpeg -r 10 -i %d.jpg -b 15000k ~/Screencast/$DATE.mov
	exit 0;
}



Help ()
{
	echo "Usage: timelapse.sh [MODE] [OPTION]"
	echo ""
	echo "  Modes:"
	echo -e "    timelapse \tStart recording your desktop. This is the default mode."
	echo -e "    encode \tEncode a video."
	echo -e "    kill \tStop recording."
	echo -e "    killall \tStop recording and encoding."
	echo -e "    help \tShow this message."
	#echo "  Options:"
	#echo -e "    all \tEncode all subfolders, not just Today's."
	#echo -e "    directory\t ."
	#echo -e "    width \t The width of the desired out video."
	exit 0;
}


ARGS=$#
SHIFT_COUNT=0

## Handle the arguments.
if test $ARGS -gt 0
then
while (test $SHIFT_COUNT -le $ARGS)
do
	case  $1  in
			"timelapse")Timelapse;;
			"encode")	Encode;;
			"export")	Encode;;
			"kill")		Kill;;
			"killall")	Killall;;
			"help")		Help;;
			*)			project=$1;;	##	Assume it is a directory.
	esac
	shift
	#let SHIFT_COUNT++
	#SHIFT_COUNT=`expr $SHIFT_COUNT + 1`
done
fi

Timelapse
exit 1;


