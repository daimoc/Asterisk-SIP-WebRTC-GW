#!/bin/sh

# Astersi webrtc installation script with self sign certificat

#Asterisk installation

INST_ROOT=/vagrant
apt-get update

cd /usr/local/src

wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz


tar -zxvf asterisk-16-current.tar.gz

rm asterisk-16-current.tar.gz
cd /usr/local/src/asterisk*

#cd contrib/scripts

#./install_prereq install

#cd ../..
sudo DEBIAN_FRONTEND=noninteractive apt install -y wget gcc g++ ncurses-dev libxml2-dev libsqlite3-dev \
libsrtp-dev uuid-dev libssl-dev libjansson-dev build-essential libedit-dev

./configure
make && make install

#sleect res_crypto, res_http_websocket, and res_pjsip_transport_websocket and opus

make samples && make config

#Astersisk webrtc Installation
mkdir /etc/asterisk/keys

cd $INST_ROOT/scripts
./ast_tls_cert -C 192.168.33.10 -O "My Super Company" -d /etc/asterisk/keys


#cat $INST_ROOT/asterisk_config/http.conf >> /etc/asterisk/http.conf

#cat $INST_ROOT/asterisk_config/pjsip.conf >> /etc/asterisk/pjsip.conf


#configure turn server

#cat $INST_ROOT/asterisk_config/extentions.conf >> /etc/asterisk/extentions.conf

##asterisk -rx "restart"#


#cyber_mega_phone_2k installation
#cd /usr/local
apt-get -y install git nginx
#git clone https://github.com/asterisk/cyber_mega_phone_2k.git

cd /usr/local
git clone https://github.com/agilityfeat/webrtc-sip-example.git

cd webrtc-sip-example

sudo sh -c "echo 'noload => chan_sip.so' >> /etc/asterisk/modules.conf"

cp -f asterisk-conf/* /etc/asterisk
#push nginx configure
cp $INST_ROOT/nginx_config/local /etc/nginx/sites-enabled
service nginx restart
