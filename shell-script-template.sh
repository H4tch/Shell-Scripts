#!/bin/sh

Help ()
{	
	echo "Usage: $0 [Options]"
	echo "The Options are:"
	echo "	help 		--Show this help message"
	exit 1
}


# Go through the command line arguments.
ARGS=$#
SHIFT_COUNT=0
if test $ARGS -gt 0
then
while (test $SHIFT_COUNT -le $ARGS)
do
	case  $1  in
			"help")			Help;;
	esac
	shift ${SHIFT_COUNT}
	SHIFT_COUNT=`expr $SHIFT_COUNT + 1`
done
fi
# End argument processing.



