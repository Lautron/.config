#!/bin/sh
shortcuts=(space ctrl+a ctrl+c enter ctrl+shift+e ctrl+v Escape space ctrl+a ctrl+x enter)
time=(0.1 0.1 0.1 0.1 0.1 0.1 0.15 0.15 0.15 0.15)
for i in "${!shortcuts[@]}"; do
    xdotool key "${shortcuts[i]}"
    sleep "${time[i]}"
done

