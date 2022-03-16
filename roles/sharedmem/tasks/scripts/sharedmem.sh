#!/bin/bash

#### disable shared memory /etc/fstab
echo "#secure shared memory" | sudo tee -a /etc/fstab
echo -e 'none /run/shm tmpfs defaults,ro 0 0' | sudo tee -a /etc/fstab 