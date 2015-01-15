#!/bin/bash

APP=$1
CURRENT_DIRECTORY="~"

function change_directory {
  candidate=$(tsuru app-run "cd $CURRENT_DIRECTORY && cd $2 &> /dev/null && pwd" -a $APP)

  if [ -d "$candidate" ]; then
    CURRENT_DIRECTORY=$candidate
  else
    echo "Directory $2 not found"
  fi
}

echo "Welcome to tsuru shell"
echo ""

while true; do
    printf "$APP $CURRENT_DIRECTORY $ "
    read cmd
    if [[ $cmd == cd* ]] ; then
      change_directory $cmd
    else
      tsuru app-run "cd $CURRENT_DIRECTORY && $cmd" -a $APP
    fi
done
