#!/bin/bash

printf "\e[35m ____   __    ____    __    __    __      __    _  _ 
\e[35m(  _ \ /__\  (  _ \  /__\  (  )  (  )    /__\  ( \/ )
\e[35m )___//(__)\  )   / /(__)\  )(__  )(__  /(__)\  )  ( 
\e[35m(__) (__)(__)(_)\_)(__)(__)(____)(____)(__)(__)(_/\_)\e[0m\n"

printf "\n\e[94mRunning Nginx PHP-FPM web mode\e[0m\n\n"

/configure.sh

printf "\n\e[94mStarting supervisord\e[0m\n\n"

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
