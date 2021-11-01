#!/bin/sh
shortcuts=(space ctrl+a ctrl+c enter ctrl+shift+e ctrl+v Escape space ctrl+a ctrl+x enter)
for i in "${!shortcuts[@]}"; do
    xdotool key "${shortcuts[i]}"
    sleep 0.1
done

