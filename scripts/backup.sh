#!/bin/bash

rsync -iPa -v --exclude={'venv','node_modules'} ~/Documents/ lautarob-netbook:~/Documents/
