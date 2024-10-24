#!/bin/bash
set -e
while true; do
	darktime=$(date -d "17:30" +"%s")
	littime=$(date -d "05:30" +"%s")
        now=$(date +"%s")
        if [ $now -gt $darktime ]; then
                /usr/bin/lookandfeeltool -a 'org.kde.breezedark.desktop'
                sec=$(( $(date -d "23:59:59" +"%s") - $now ))
                sectotime=$(date -u -d @${sec} +"%Hh%Mm%Ss")
                echo "Sleeping for $sectotime"
                sleep $sec
        elif [ $now -lt $littime ]; then
                /usr/bin/lookandfeeltool -a 'org.kde.breezedark.desktop'
                sec=$(( $littime - $now ))
                sectotime=$(date -u -d @${sec} +"%Hh%Mm%Ss")
                echo "Sleeping for $sectotime"
                sleep $sec
        else
                /usr/bin/lookandfeeltool -a 'org.kde.breeze.desktop'
                sec=$(( $darktime - $now ))
                sectotime=$(date -u -d @${sec} +"%Hh%Mm%Ss")
                echo "Sleeping for $sectotime"
                sleep $sec
        fi
done
