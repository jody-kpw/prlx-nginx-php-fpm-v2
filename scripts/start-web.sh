#!/bin/bash

printf "\e[35m
\e[35m                       _ _                \e[0m__\e[94m     _____ 
\e[35m                      | | |              \e[0m/ /\e[94m    / __  \ 
\e[35m _ __   __ _ _ __ __ _| | | __ ___  __  \e[0m/ \e[94m__   _\`\' / /\'
\e[35m| \'_ \ / _\` | \'__/ _\` | | |/ _\` \ \/ / \e[0m/ /\e[94m\ \ / / / /  
\e[35m| |_) | (_| | | | (_| | | | (_| |>  < \e[0m/ /\e[94m  \ V /./ /___
\e[35m| .__/ \__,_|_|  \__,_|_|_|\__,_/_/\_\e[0m/_/\e[94m    \_/ \_____/
\e[35m| |                                                    
\e[35m|_|\e[0m                              \n"

printf "\n\e[94mRunning Nginx PHP-FPM web mode\e[0m\n\n"

/configure.sh

printf "\n\e[94mStarting supervisord\e[0m\n\n"

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
