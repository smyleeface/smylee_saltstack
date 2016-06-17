#!/usr/bin/env bash

#mkdir /home/vagrant/.ssh
mkdir -m 0700 -p /home/vagrant/.ssh
#wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
#wget --no-check-certificate 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys

cat <<EOM >/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8Y\
Vr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdO\
KLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7Pt\
ixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmC\
P3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW\
yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOM
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
#chown -R vagrant /home/vagrant/.ssh
#chmod -R go-rwsx /home/vagrant/.ssh


#useradd rita -g root -G wheel -u 900
#echo "rita" | passwd --stdin rita

#groupadd vagrant -g 999
#useradd vagrant -g vagrant -G wheel -u 900
#echo "vagrant" | passwd --stdin vagrant
#echo "%vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
#sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers




#  ADD VAGRANT users to sudoers
#wget -O/etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem
#groupadd vagrant -g 999
#useradd vagrant -g vagrant -G wheel -u 900
#echo "vagrant" | passwd --stdin vagrant
#echo "%vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
#sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
###sed -i "s/^.*!visiblepw/#Defaults !visiblepw/" /etc/sudoers

## INSTALL vagrant keys
#mkdir -m 0700 -p /home/vagrant/.ssh
#wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
#chmod 600 /home/vagrant/.ssh/authorized_keys
#chown -R vagrant:vagrant /home/vagrant/.ssh

#cat <<EOF > /etc/sudoers.d/wheel
#Defaults:%wheel env_keep += "SSH_AUTH_SOCK"
#Defaults:%wheel !requiretty
#%wheel ALL=(ALL) NOPASSWD: ALL