#!/sbin/sh
trap 'exit' SIGINT
for (( i = 0; i < ${1:-100}; i++ )); do
  play -v 0.5 ~/.config/alarm/alarm.mp3
done
