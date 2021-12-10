#!/bin/bash
rsync -iPa -v -e "ssh -i $HOME/.ssh/id_rsa" --exclude={'venv','node_modules'} ~/Documents/ lautarob-netbook:~/Documents/

