id=$(xsetwacom list devices | grep -Po 'id: \K(\d\d)(?=\stype: PAD)')
xsetwacom set $id Button 1 "key +ctrl z -ctrl"
xsetwacom set $id Button 2 "key +del -del"
