#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with  or as root.' >&2
   exit 1
fi

ufw --force enable

ufw default deny outgoing comment 'deny all outgoing traffic'

ufw default deny incoming comment 'deny all incoming traffic'

ufw limit in 22 comment 'allow ssh connections in'

ufw allow out 22 comment 'allow ssh out'

ufw limit in 2277 comment 'allow ssh connections in on port 2277'

ufw allow out 2277 comment 'allow ssh connections out on port 2277'

ufw limit in 60015/udp comment 'mosh custom port'

#ufw limit in 60000:60020/udp comment 'mosh limit in '

ufw allow out 60000:60020/udp comment 'mosh out'

ufw allow out 53 comment 'allow dns'

ufw allow out 443 comment 'allow ssl'

# ufw allow out 123 comment 'allow ntp'

ufw allow out http comment 'allow http traffic'

ufw allow out 9050 comment 'allow tor'

ufw allow out 9051 comment 'tor control port'

ufw allow out 43 comment 'allow whois'

# write rule just like this for wireguard
ufw allow 51820/udp comment 'allow wireguard'

ufw allow out 61951/udp comment 'allow other wireguard'

ufw allow out 5015 comment 'allow logzio'

ufw allow out 5044 comment 'allow filebeat'

ufw allow out 8080 comment 'OoklaServer-speedtest 8080'

ufw allow out 5060 comment 'OoklaServer-speedtest 5060'

# ufw allow openvpn comment 'allow opnvpn'

# ufw allow out on tun0

#echo "yes" | ufw enable

sed -i "s/IPV6=yes/IPV6=no/" /etc/default/ufw

#reload firewall after making changes
ufw reload








