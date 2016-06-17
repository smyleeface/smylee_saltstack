build-manditory:
  pkg.installed:
    - pkgs:
      - autoconf
      - wget
      - automake
      - binutils
      - bison
      - flex
      - gcc
      - gcc-c++
      - gettext
      - libtool
      - make
      - patch
      - pkgconfig
      - rpm-build
      - zip
      - xz
      - curl
      - llvm

build-default:
  pkg.installed:
    - pkgs:
      - cscope
      - ctags
      - cvs
      - diffstat
      - doxygen
      - elfutils
      - gcc-gfortran
      - intltool
      - patchutils
      - rcs
      - subversion
      - swig
      - systemtap
      - sqlite-devel
      - readline-devel
      - dos2unix
    - require:
      - pkg: build-manditory

build-dev:
  pkg.installed:
    - pkgs:
      - zlib-devel
      - bzip2-devel
      - libffi-devel
      - openssl-devel
      - xz-libs
      - python-devel
      - python
      - python-pip
      - mysql-devel
      - supervisor
    - failhard: True
    - reload_modules: True
    - require:
      - pkg: build-manditory
      - pkg: build-default

boto-runner:
  module.run:
    - name: pip.install
    - bin_env: /usr/bin/pip
    - user: root
    - require:
      - pkg: build-dev

pip-mysql-runner:
  module.run:
    - name: pip.install
    - pkgs: pymysql
    - bin_env: /usr/bin/pip
    - user: root
    - require:
      - pkg: build-dev

essential-packages:
  pkg.installed:
    - names:
      - git
      - tmux
      - ntp

git_latest_version:
  pkg.latest:
    - name: git