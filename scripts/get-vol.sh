#!/bin/bash

pactl list sinks | grep "Volume" -m 1 | awk '{ print $5 }'
