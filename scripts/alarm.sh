#!/sbin/sh
trap 'exit' SIGINT
while [[ true ]]; do play -v 0.5 ~/.config/alarm/alarm.mp3; done

