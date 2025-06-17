#!/bin/bash
set -e
while true; do
    darktime=$(date -d "17:30" +"%s")
    littime=$(date -d "06:30" +"%s")
    now=$(date +"%s")

    if [ $now -ge $darktime ] || [ $now -lt $littime ]; then
        /usr/bin/lookandfeeltool -a 'org.kde.breezedark.desktop'
        if [ $now -ge $darktime ]; then
            # Se for depois das 17:30, calcular até 23:59:59 do mesmo dia
            sec=$(( $(date -d "23:59:59" +"%s") - $now ))
            if [ $sec -le 10 ]; then
                # Se já passou de 23:59:59, calcular até 06:30 do próximo dia
                sec=$(( $(date -d "tomorrow 06:30" +"%s") - $now ))
            fi
        else
            # Se for antes das 06:30, calcular até 06:30 do mesmo dia
            sec=$(( $littime - $now ))
        fi
    else
        /usr/bin/lookandfeeltool -a 'org.kde.breeze.desktop'
        # Calcular até 17:30 do mesmo dia
        sec=$(( $darktime - $now ))
    fi

    # Garantir que sec seja positivo
    if [ $sec -le 10 ]; then
        sec=10
    fi

    sectotime=$(date -u -d @${sec} +"%Hh%Mm%Ss" || echo "00h00m10s")
    echo "Sleeping for $sectotime"
    sleep $sec
done
