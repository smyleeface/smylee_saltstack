{% set environment = pillar['default'] %}
{% set nginx = pillar['nginx'] %}

create_shiny-palm-tree:
  file.directory:
    - name: /var/www/shiny-palm-tree
    - user: {{ nginx.group }}
    - mode: 755
    - makedirs: True
    - unless: test -d /var/www/shiny-palm-tree

nginx_conf_shiny-palm-tree:
  file.managed:
    - name: /etc/nginx/sites-available/shiny-palm-tree.conf
    - source: salt://shiny-palm-tree/nginx.conf
    - template: jinja
    - force: True
    - context:
        port: {{ environment.port }}
        server: {{ environment.server}}
    - group: {{ nginx.group }}
    - user: {{ nginx.user }}

git_shiny-palm-tree:
  git.latest:
    - name: https://github.com/smyleeface/shiny-palm-tree
    - rev: master
    - target: /var/www/shiny-palm-tree
    - force_fetch: True
    - force_checkout: True
    - force_clone: True
    - force_reset: True

shiny-palm-tree_site_chown:
  file.directory:
    - name: /var/www/shiny-palm-tree
    - group: {{ nginx.group }}
    - user: {{ nginx.user }}
    - mode: 755
    - recurse:
      - group
      - user
      - mode

/etc/nginx/sites-enabled/shiny-palm-tree.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/shiny-palm-tree.conf
    - user: {{ nginx.user }}
    - group: {{ nginx.group }}

slave_site_nginx_restart:
  service.running:
    - name: nginx
    - enable: True
    - restart: True
    - reload: True
    - watch:
        - file: nginx_conf_shiny-palm-tree