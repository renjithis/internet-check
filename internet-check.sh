#!/bin/bash

# Settings
NOTIFY_ONLINE=true
NOTIFY_OFFLINE=false
INVERT_NOTIFY=false #infinite mode
PING_ADDRESS="1.1.1.1"
PING_COUNT=5
SLEEP_INTERVAL_SECONDS=30

if [[ $# -gt 0 ]]; then
echo "Argumets = $@"
    NOTIFY_ONLINE=false
    NOTIFY_OFFLINE=false
    while getopts ":dcip" opt; do
        case ${opt} in
            d ) # process option d = disconnect notify
                NOTIFY_OFFLINE=true
            ;;
            c ) # process option c = connect notify
                NOTIFY_ONLINE=true
            ;;
            i ) # infinite mode
                INVERT_NOTIFY=true
            ;;
            p )
                PING_ADDRESS=$OPTARG
            ;;
            \? ) echo "Usage: cmd [-d] [-c] [-i] [-p PING_ADDRESS]"
            ;;
        esac
    done
fi

echo "Settings : 
$NOTIFY_OFFLINE $NOTIFY_ONLINE $INVERT_NOTIFY $PING_ADDRESS $PING_COUNT $SLEEP_INTERVAL_SECONDS"

for (( ; ; )) 
do
    PING_RESULT=$(ping -c $PING_COUNT $PING_ADDRESS)
    if [[ $PING_RESULT == "" || "$(echo $PING_RESULT | grep '100% packet loss' )" != "" ]]; then
        echo "Internet is not present"
        if [ $NOTIFY_OFFLINE = true ]; then
            DATETIME=$(date)
            zenity --info --title "Internet" --text "Offline on $DATETIME"
            if [ $INVERT_NOTIFY = true ]; then
                echo "INVERT_NOTIFY"
                NOTIFY_OFFLINE=false
                NOTIFY_ONLINE=true
            else
                exit 0
            fi
        fi
    else
        echo "Internet is present"
        if [ $NOTIFY_ONLINE = true ]; then
            DATETIME=$(date)
            zenity --info --title "Internet" --text "Online on $DATETIME"
            if [ $INVERT_NOTIFY = true ]; then
                echo "INVERT_NOTIFY"
                NOTIFY_OFFLINE=true
                NOTIFY_ONLINE=false
            else
                exit 0
            fi        
        fi
    fi
    sleep $SLEEP_INTERVAL_SECONDS
done
