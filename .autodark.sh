#!/bin/bash
set -e
darktime=$(date -d "17:30" +"%s")
littime=$(date -d "05:30" +"%s")
while true; do
        now=$(date +"%s")
        if [ $now -gt $darktime ]; then
                /usr/bin/lookandfeeltool -a 'org.kde.breezedark.desktop'
                sec=3600
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
