#!/bin/bash
#:set ff=unix
#vi /var/log/salt/minion
# ..FAILURES.. include (single quotes in/out file, permissions issues and missing directories....moodlesite.installer)
echo "=========>>> E Z SETUP >>>";

PYTHON_sym=$1;

function install_setuptools(){
	 cd /usr/local/src;
     #./configure --prefix=/usr/local && make && make altinstall
     sudo -u root wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo -u root $PYTHON_sym
}
#echo "sudo -u root /usr/bin/php /var/www/moodlesite.installer/admin/cli/install.php --fullname='$fullname' --shortname='$shortname' --adminuser='$adminuser' --adminpass='$adminpass' --dbtype='$dbtype' --dbhost='$dbhost' --dbname='$dbname' --dbuser='$dbuser' --dbpass='$dbpass' --chmod='$chmod' --prefix='$prefix' --dataroot='$dataroot' --lang='$lang' --wwwroot='$wwwroot' --dbport='$dbport' --non-interactive --agree-license --allow-unstable";

install_setuptools;
if [ $? -eq 0 ]; then
echo "changed=yes comment='setuptools installed.'";
else
echo "changed=no comment='setuptools install failed'";
fi