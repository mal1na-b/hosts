#!/bin/bash

DNS_SERVER="8.8.8.8"

verifica_ip() {
    hostname="$1"
    ip="$2"
    dns_server="$3"

    if [[ ! "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "IP invalid: $ip - $hostname"
        return
    fi

    for octet in ${ip//./ }
    do
        if (( octet > 255 )); then
            echo "IP invalid: $ip - $hostname"
            return
        fi
    done

    dns_ip=$(dig +short @"$dns_server" "$hostname" A | head -n 1)

    if [ "$dns_ip" = "$ip" ]; then
        echo "Asociere valida: $hostname - $ip"
    else
        echo "Asociere invalida: $hostname - $ip"
    fi
}

while read -r ip hostname rest
do
    if [[ "$ip" != "#"* && -n "$hostname" ]]; then
        verifica_ip "$hostname" "$ip" "$DNS_SERVER"
    fi
done < /etc/hosts

echo "Adaugat de Ioana"
