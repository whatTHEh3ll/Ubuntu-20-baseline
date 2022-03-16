#!/bin/bash

#### Disable Anacron
sed -i 's/^[^#]*25/#&/' /etc/crontab  

sed -i 's/^[^#]*47/#&/' /etc/crontab  

sed -i 's/^[^#]*52/#&/' /etc/crontab  

sed -i 's/#25/# 25/' /etc/crontab 

sed -i 's/#47/# 47/' /etc/crontab 

sed -i 's/#52/# 52/' /etc/crontab 

# disable at
apt-get purge at -y

