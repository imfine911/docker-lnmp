#!/bin/sh
# shellcheck disable=SC2046
path=$(cd $(dirname -- "$0") && pwd )
echo  "$path"

# shellcheck disable=SC2039
array=(${path//// })

# shellcheck disable=SC2068
echo ${array[@]: -1}

# shellcheck disable=SC2145
docker exec php8.1 /bin/sh -c "cd /var/www/${array[@]: -1} && php start.php $1"


