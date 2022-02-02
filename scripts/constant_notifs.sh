while true; do
  sleep $(shuf -i1800-10800 -n1)
  dunstify -t 0 "Are you inventing things to do to avoid the important?"
done
