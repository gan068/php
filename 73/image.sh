#!/usr/bin/env bash

cd `dirname $0`

PHP_VERSION="7.3.11"
IMAGE_NAME="gcr.io/cw-dev-service/php-fpm:${PHP_VERSION}-base"
BRANCH="develop"
ASSETS_VERSION="dev"

if [ "1$PROD" = '11' ]; then
    IMAGE_NAME="gcr.io/cw-web-service/php-fpm:${PHP_VERSION}-base"
    BRANCH="release"
    ASSETS_VERSION="prod"
fi

case "$1" in
    build)
        docker build -t $IMAGE_NAME .
        ;;

    push)
        docker push $IMAGE_NAME
        ;;
    *)
        echo $"Usage: $0 {build|push}"
        exit 1
esac
