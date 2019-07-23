#!/bin/bash

PLATFORM='unknown'
UNAMESTR=`uname`
if [[ "$UNAMESTR" == 'Linux' ]]; then
   PLATFORM='linux'
elif [[ "$UNAMESTR" == 'Darwin' ]]; then
   PLATFORM='darwin'
fi

printf "Running on $PLATFORM"

#make $PLATFORM

# Update the readme.md from the template

rm -f README.md
cp README-template.md README.md

if [[ "$PLATFORM" == 'linux' ]]; then
   PLATFORM='linux'
elif [[ "$PLATFORM" == 'darwin' ]]; then
  	sed -i '' -e "s/{{ PHP7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ PHP7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ PHP7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ NGINX7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i '' -e "s/{{ NGINX7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i '' -e "s/{{ NGINX7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
fi



