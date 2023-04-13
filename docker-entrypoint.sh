#!/bin/bash

append_if_absent()
{
    local string=$1
    local file=$2

    if grep -q -x -v "$string" $file; then
        echo $string >> $file
    fi
}

a2enmod rewrite 
a2enmod cgi 
service apache2 start

# append_if_absent "Listen ${KOHA_INTRANET_PORT}" /etc/apache2/ports.conf
# append_if_absent "Listen ${KOHA_OPAC_PORT}"     /etc/apache2/ports.conf

append_if_absent "Listen 8080" /etc/apache2/ports.conf
# append_if_absent "Listen ${KOHA_OPAC_PORT}"     /etc/apache2/ports.conf

/bin/bash -c "trap : TERM INT; sleep infinity & wait"
