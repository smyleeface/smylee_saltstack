# Basic Saltstacks
Uses [Saltstack](http://docs.saltstack.com/en/latest/) to launch local boxes for different projects and packer to launch in AWS.

## Project Prerequisites
The following tools need to be installed on your local computer before running any of the projects.
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Packer](http://www.packer.io/downloads.html)
* [VirtualBox/guest additions](https://www.virtualbox.org/wiki/Downloads)
* CentOS Box - Before running any of the projects below, you will need to create a CentOS box. It will build an image and takes a little bit of time to build, but once it's built, you don't have to do it again.
	1. `cd packer`
	2. `packer build centos68_build.json`
	3. This will create a directory `build/centos-6.8-x86_64.box` within the packer directory approximately 260MB in size. All projects below will reference this box when running vagrant.

## Local Setup
All vagrant projects use CentOS with an NGINX web server.

### Basic Server
Sample of a simple server setup with Vagrant and Packer. Also used for development and testing of python scripts. Will add more languages for support in future (like php.)

local: `vagrant up server`

browser: `localhost:8080`

ssh: `vagrant ssh server`

run salt again: `sudo salt-call state.sls shiny-palm-tree`

