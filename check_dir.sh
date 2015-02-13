#!/bin/bash
# search into log directory for files that are getting bigger than a certain threshold
search_dir="/var/log/"
STATUS_OK=0
STATUS_CRITICAL=2
THRESHOLD=$1

for entry in `ls -1 /var/log/ | xargs -n1 -i%f echo '%f'`
do
    if [ "$entry" != "back" ] ; then
    full_path="$search_dir""$entry"

    FILENAME="$full_path"
    FILESIZE=$(stat -c%s "$FILENAME")
    if [[ $FILESIZE -gt $THRESHOLD ]] ; then
        echo "CRITICAL! File "$FILENAME" Bigger than Threshold: "$THRESHOLD
        exit $STATUS_CRITICAL
    fi
    fi
done
        echo "OK"
        exit $STATUS_OK
