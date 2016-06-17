 {% set python_version = pillar['python27']['version'] %}
 {% set python_home = pillar['python27']['home'] %}
 {% set python_hash = pillar['python27']['source_hash'] %}

#unless python2.7 exists
/usr/local/src/Python-{{python_version}}.tgz:
  file.managed:
    - source_hash: {{ python_hash }}
    - source: https://www.python.org/ftp/python/{{python_version}}/Python-{{python_version}}.tgz
    - onlyif: test ! -f /usr/local/src/Python-{{python_version}}.tgz
    - unless: test -e /usr/bin/python27


#dos2unix winfile.sh unixfile.sh
/usr/local/src/scripts_python:
  file.recurse:
    - source: salt://python/scripts
    - clean: True
    - group: www-data
    - user: www-data

python_scripts_owner:
  file.directory:
    - name: /usr/local/src/scripts_python
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

build-dependenices:
  pkg.installed:
    - pkgs:
      - dos2unix

script_python_clense:
  cmd.run:
    - cwd: /usr/local/src/scripts_python
    - name: sudo -u root find *.sh -type f | while read f; do sudo -u root dos2unix $f ; done
    - user: root
    - group: root


python_install:
  cmd.run:
    - name: sudo -u root sh /usr/local/src/scripts_python/install.sh '{{python_version}}' '{{python_home}}' '/usr/local/src/Python-{{python_version}}' 'tgz'
    # FAILURE WILL OCCUR IF TAR IS NOT INSTALLED'
    - stateful: True
    - user: root
    - group: root
    - unless: test -e /usr/bin/python27

libff_install:
  pkg.installed:
    - names:
      - libffi-devel
