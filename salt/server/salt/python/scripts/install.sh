#!/bin/bash
#:set ff=unix
#vi /var/log/salt/minion
# ..FAILURES.. include (single quotes in/out file, permissions issues and missing directories....moodlesite.installer)
echo "=========>>> P Y T H O N >>>";

version=$1;
home=$2;
dir=$3;
ext=$4;
HOMEForced=/usr/local;

function install_python(){
   cd /usr/local/src;
     sudo -u root tar xzf $dir.$ext;
     cd $dir;
     #./configure --prefix=/usr/local && make && make altinstall
     ./configure --prefix=$HOMEForced && make && make altinstall
     wait;
     echo $?
     export PYTHON_HOME=$HOMEForced;
   export PATH=$PYTHON_HOME/bin:$PATH;
   ln -s $HOMEForced/bin/python2.7 /usr/bin/python27;
}
#echo "sudo -u root /usr/bin/php /var/www/moodlesite.installer/admin/cli/install.php --fullname='$fullname' --shortname='$shortname' --adminuser='$adminuser' --adminpass='$adminpass' --dbtype='$dbtype' --dbhost='$dbhost' --dbname='$dbname' --dbuser='$dbuser' --dbpass='$dbpass' --chmod='$chmod' --prefix='$prefix' --dataroot='$dataroot' --lang='$lang' --wwwroot='$wwwroot' --dbport='$dbport' --non-interactive --agree-license --allow-unstable";

install_python;
if [ $? -eq 0 ]; then
echo "changed=yes comment='python installed.'";
else
echo "changed=no comment='python install failed'";
fi