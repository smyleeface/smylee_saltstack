{% set nginx = pillar['nginx'] %}

web_user:
  group.present:
    - name: {{ nginx.user }}
    - gid: 501
  user.present:
    - name: {{ nginx.user }}
    - home: /home/{{ nginx.user }}
    - shell: /bin/bash
    - uid: 501
    - groups:
      - {{ nginx.group }}

nginx_repo:
  file.managed:
    - name: /etc/yum.repos.d/nginx.repo
    - source: salt://nginx/nginx.repo
    - template: jinja
    - group: {{ nginx.group }}
    - user: {{ nginx.user }}
    - mode: 755

nginx:
  pkg:
    - installed

nginx_update:
  pkg.latest:
    - name: nginx
  cmd.run:
    - name: yum update nginx -y


nginx_conf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - user: root
    - mode: 644
    - template: jinja
    - unless: test -d /etc/nginx/nginx.conf

nginx_mimetypes:
  file.managed:
    - name: /etc/nginx/mime.types
    - source: salt://nginx/mime.types
    - user: root
    - group: root
    - mode: 644
    - unless: test -d /etc/nginx/mime.types

nginx_www_dir:
  file.directory:
    - name: /var/www
    - group: {{ nginx.group }}
    - user: {{ nginx.user }}
    - makedirs: True
    - unless: test -d /var/www

nginx_sites_available:
  file.directory:
    - name: /etc/nginx/sites-available
    - user: root
    - mode: 755
    - makedirs: True
    - unless: test -d /etc/nginx/sites-available

nginx_sites_enabled:
  file.directory:
    - name: /etc/nginx/sites-enabled
    - user: root
    - mode: 755
    - makedirs: True
    - unless: test -d /etc/nginx/sites-enabled

nginx_move_default:
  file.rename:
    - name: /etc/nginx/conf.d/default.conf.old
    - source: /etc/nginx/conf.d/default.conf
    - force: True

nginx_lib:
  file.directory:
    - name: /var/lib/nginx
    - group: {{ nginx.group }}
    - user: {{ nginx.user }}
    - mode: 700
    - recurse:
      - group
      - user
      - mode

nginx_watch:
  service:
    - running
    - name: nginx
    - enable: True
    - restart: True
    - reload: True
    - onlyif: test -d /etc/nginx/sites-enabled

nginx_enable_on_boot:
  service.enabled:
    - name: nginx
