#!/bin/bash

echo "Digite a hora"
read hora

darktime=$(date -d "17:30" +"%s")
littime=$(date -d "06:30" +"%s")
now=$(date -d "${hora}" +"%s")

if [ $now -ge $darktime ] || [ $now -lt $littime ]; then
    /usr/bin/lookandfeeltool -a 'org.kde.breezedark.desktop'
    if [ $now -ge $darktime ]; then
        # Se for depois das 17:30, calcular até 06:30 do próximo dia
        end_of_day=$(date -d "tomorrow 06:30" +"%s")
        sec=$(( end_of_day - now ))
    else
        # Se for antes das 06:30, calcular até 06:30 do mesmo dia
        sec=$(( littime - now ))
    fi
else
    /usr/bin/lookandfeeltool -a 'org.kde.breeze.desktop'
    # Calcular até 17:30 do mesmo dia
    sec=$(( darktime - now ))
fi

# Garantir que sec seja pelo menos 10 segundos
if [ $sec -le 10 ]; then
    sec=10
fi

sectotime=$(date -u -d @${sec} +"%Hh%Mm%Ss" || echo "00h00m${sec}s")
echo "Sleeping for $sectotime"
sleep $sec