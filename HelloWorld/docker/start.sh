#!/bin/sh

echo "Start Script for HelloWorld"

# Initialise the PID of the application
pid=0

# define the SIGTERM-handler
term_handler() {
  echo 'Handler called'
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# on signal execute the specified handler
trap 'term_handler' SIGTERM

# run application in the background and set the PID
echo "Starting the Dockerized IVCT HelloWorld System under Test"

# call the TC exec
chmod a+x /root/application/HelloWorld/bin/HelloWorld

sh /root/application/HelloWorld/bin/HelloWorld

pid="$!"

wait "$pid"
