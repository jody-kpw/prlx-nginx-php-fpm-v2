#!/bin/bash

printf "\e[1m\e[35m
\e[1m\e[35m                       _ _                \e[90m__\e[94m     _____ 
\e[1m\e[35m                      | | |              \e[90m/ /\e[94m    / __  \ 
\e[1m\e[35m _ __   __ _ _ __ __ _| | | __ ___  __  \e[90m/ \e[94m__   _\`\' / /\'
\e[1m\e[35m| \'_ \ / _\` | \'__/ _\` | | |/ _\` \ \/ / \e[90m/ /\e[94m\ \ / / / /  
\e[1m\e[35m| |_) | (_| | | | (_| | | | (_| |>  < \e[90m/ /\e[94m  \ V /./ /___
\e[1m\e[35m| .__/ \__,_|_|  \__,_|_|_|\__,_/_/\_\e[90m/_/\e[94m    \_/ \_____/
\e[1m\e[35m| |                                                    
\e[1m\e[35m|_|\e[0m                              \n"

printf "\n\e[94mRunning Nginx PHP-FPM worker mode\e[0m\n\n"

/configure-worker.sh

printf "\n\e[94mStarting supervisord\e[0m\n\n"

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
