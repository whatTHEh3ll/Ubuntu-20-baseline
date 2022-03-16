#! /bin/bash

# /usr/local/sbin/block
# BoneKracker
# Rev. 11 October 2012
# Tested with ipset 6.13

# Purpose: Load DShield.org Recommended Block List into an ipset in a running
# firewall.  That list contains the networks from which the most malicious
# traffic is being reported by DShield participants.

# Notes: Call this from crontab. Feed updated every 15 minutes.
# netmask=24: dshield's list is all class C networks
# hashsize=64: default is 1024 but 64 is more than needed here


target="https://feeds.dshield.org/block.txt"
ipset_params="hash:ip --netmask 24 --hashsize 64"

filename=$(basename ${target})
firewall_ipset=${filename%.*}           # ipset will be filename minus ext
data_dir="/var/tmp/${firewall_ipset}"   # data directory will be same
data_file="${data_dir}/${filename}"

# if data directory does not exist, create it
mkdir -pm 0750 ${data_dir}

# function to get modification time of the file in log-friendly format
# stderr redirected in case file is not present
get_timestamp() {
    date -r $1 +%m/%d' '%R
}

# file modification time on server is preserved during wget download
[ -w $data_file ] && old_timestamp=$(get_timestamp ${data_file})

# fetch file only if newer than the version we already have
wget -qNP ${data_dir} ${target}

if [ "$?" -ne "0" ]; then
    logger -p cron.err "IPSet: ${firewall_ipset} wget failed."
    exit 1
fi

timestamp=$(get_timestamp ${data_file})

# compare timestamps because wget returns success even if no newer file
if [ "${timestamp}" != "${old_timestamp}" ]; then

    temp_ipset="${firewall_ipset}_temp"
    ipset create ${temp_ipset} ${ipset_params}

    networks=$(sed -rn 's/(^([0-9]{1,3}\.){3}[0-9]{1,3}).*$/\1/p' ${data_file})

    for net in $networks; do
        ipset add ${temp_ipset} ${net}
    done

    # if ipset does not exist, create it
    ipset create -exist ${firewall_ipset} ${ipset_params}

    # swap the temp ipset for the live one
    ipset swap ${temp_ipset} ${firewall_ipset}
    ipset destroy ${temp_ipset}

    # log the file modification time for use in minimizing lag in cron schedule
    logger -p cron.notice "IPSet: ${firewall_ipset} updated (as of: ${timestamp})."

fi 