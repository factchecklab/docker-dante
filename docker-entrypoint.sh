#!/bin/sh

set -e

: ${SOCKD_USER_NAME:=user}

echo $1 | grep -q ^sockd- || exec "$@"

case $1 in
    'sockd-username')
        if [ -z ${SOCKD_USER_PASSWORD+X} ]; then
            echo "Set \$SOCKD_USER_PASSWORD variable"
            exit 1
        fi

        adduser -D $SOCKD_USER_NAME

        echo $SOCKD_USER_NAME:$SOCKD_USER_PASSWORD |chpasswd

        exec sockd
    ;;
esac
