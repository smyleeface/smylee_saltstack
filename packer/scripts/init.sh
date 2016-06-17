#!/usr/bin/env bash

yum -y --enablerepo rpmforge install dkms
yum -y groupinstall 'Development Tools'
#yum -y install kernel-devel-2.6.32-504.e16.x86_64
