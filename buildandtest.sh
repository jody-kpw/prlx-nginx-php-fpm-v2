#!/bin/bash
set -e
PLATFORM='unknown'
UNAMESTR=`uname`
if [[ "$UNAMESTR" == 'Linux' ]]; then
   PLATFORM='linux'
elif [[ "$UNAMESTR" == 'Darwin' ]]; then
   PLATFORM='darwin'
fi

printf "Running on $PLATFORM"

make $PLATFORM --jobs=8

# Update the readme.md from the template

# Fill in the PHP/Nginx versions automatically into the readme
rm -f README.md
cp README-template.md README.md

if [[ "$PLATFORM" == 'linux' ]]; then
   	sed -i -e "s/{{ PHP7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i -e "s/{{ PHP7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i -e "s/{{ PHP7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i -e "s/{{ NGINX7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i -e "s/{{ NGINX7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i -e "s/{{ NGINX7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i -e "s/{{ COMPOSER7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i -e "s/{{ COMPOSER7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i -e "s/{{ COMPOSER7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i -e "s/{{ BRANCH }}/$bamboo_planRepository_branchName/g" README.md
	sed -i -e "s/{{ LAST_BUILD }}/`date`/g" README.md
elif [[ "$PLATFORM" == 'darwin' ]]; then
  	sed -i '' -e "s/{{ PHP7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ PHP7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ PHP7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 "/usr/bin/php" "-r" "echo phpversion();"`/g" README.md
	sed -i '' -e "s/{{ NGINX7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i '' -e "s/{{ NGINX7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i '' -e "s/{{ NGINX7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 'nginx' '-v' 2>&1 | sed -e 's/nginx version: nginx\///g'`/g" README.md
	sed -i '' -e "s/{{ COMPOSER7.1 }}/`docker run prlx-nginx-php-fpm:earth-7.1 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i '' -e "s/{{ COMPOSER7.2 }}/`docker run prlx-nginx-php-fpm:earth-7.2 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i '' -e "s/{{ COMPOSER7.3 }}/`docker run prlx-nginx-php-fpm:earth-7.3 'composer' '-V' 2>&1 | sed -e 's/Composer version //g'`/g" README.md
	sed -i '' -e "s/{{ BRANCH }}/$bamboo_planRepository_branchName/g" README.md
	sed -i '' -e "s/{{ LAST_BUILD }}/`date`/g" README.md
fi

# PHP Module lists
docker run -e ATATUS_APM_LICENSE_KEY=test prlx-nginx-php-fpm:earth-7.1 "/bin/bash" "-c" "/configure.sh > /dev/null && php -m" > test/php/module_lists/7.1.list
docker run -e ATATUS_APM_LICENSE_KEY=test prlx-nginx-php-fpm:earth-7.2 "/bin/bash" "-c" "/configure.sh > /dev/null && php -m" > test/php/module_lists/7.2.list
docker run -e ATATUS_APM_LICENSE_KEY=test prlx-nginx-php-fpm:earth-7.3 "/bin/bash" "-c" "/configure.sh > /dev/null && php -m" > test/php/module_lists/7.3.list

# Process the lists into the readme
docker run -v $PWD:/src prlx-nginx-php-fpm:earth-7.3 "php" "/src/test/php/modules.php"

# Push to Docker
docker tag prlx-nginx-php-fpm:earth-7.1 prlx/prlx-nginx-php-fpm-v2:7.1-$bamboo_planRepository_branchName
docker tag prlx-nginx-php-fpm:earth-7.2 prlx/prlx-nginx-php-fpm-v2:7.2-$bamboo_planRepository_branchName
docker tag prlx-nginx-php-fpm:earth-7.3 prlx/prlx-nginx-php-fpm-v2:7.3-$bamboo_planRepository_branchName
docker push prlx/prlx-nginx-php-fpm-v2:7.1-$bamboo_planRepository_branchName
docker push prlx/prlx-nginx-php-fpm-v2:7.2-$bamboo_planRepository_branchName
docker push prlx/prlx-nginx-php-fpm-v2:7.3-$bamboo_planRepository_branchName