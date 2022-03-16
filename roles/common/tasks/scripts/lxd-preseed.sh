#!/bin/bash

echo "\e[32mCreate Preseed File \e[0m"

cat >> lxdconfig.yaml << EOF
    config: {}
    networks:
    - config:
             ipv4.address: auto
             ipv6.address: none  
      description: ""
      managed: false
      name: lxdbr0
      type: bridge
    storage_pools:
    - config:
         size: 20GB
      description: ""
      name: default
      driver: btrfs
    profiles:
    - config: {}
      description: ""
      devices:
              eth0:
                name: eth0
                nictype: bridged
                parent: lxdbr0
                type: nic
              root:
                path: /
                pool: default
                type: disk
      name: default
    cluster: null
EOF

echo "\e[32mInitialise LXD Using Preseed File \e[0m"
cat lxdconfig.yaml | lxd init --preseed