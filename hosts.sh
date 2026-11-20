#!/bin/bash

while read -r ip hostname rest
do
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        valid=true

        for octet in ${ip//./ }
        do
            if (( octet > 255 )); then
                valid=false
            fi
        done

        if [ "$valid" = true ]; then
            echo "IP valid: $ip - $hostname"
        else
            echo "IP invalid: $ip - $hostname"
        fi
    else
        echo "IP invalid: $ip - $hostname"
    fi

done < /etc/hosts
