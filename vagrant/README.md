St2 Vagrant
===========

###Introduction

This repo was created as a quick install of the StackStorm automation platform.  It will get you up and running with a single VM running all St2 components, as well as Mistral.

### Instructions
To provision the environment run:

    vagrant up

There will be some red messages but that is fine.  One the vm is up, connect to it via:

    vagrant ssh st2express

You can see the action list via:

    st2 action list

The supervisor script to start,stop,restart,reload, and, clean st2 is run like so:

    st2ctl start|stop|status|restart|reload|clean

### Environment Variables
Environment variables can be used to enable or disable certain features of the StackStorm deployment.

* WEBUI - Set to 0 to skip ui installation.  
    * DEFAULT: 1
* ST2VER - The version of St2 to install.
    * DEFAULT: 0.8.2
* HOSTNAME - the hostname to give the VM. 
    * DEFAULT: st2express
* BOX - the Vagrant base box
    * DEFAULT: ubuntu/trusty64

#### Usage

`HOSTNAME=st2test ST2VER=0.8.2 WEBUI=0 vagrant up`

If the hostname has been specified during `vagrant up` then it either needs to be exported or specified for all future vagrant commands related to that VM.

Example:
If the following was used to provision the VM:
`HOSTNAME=st2test vagrant up`

then status would need to be run like so:
`HOSTNAME=st2test vagrant status`

and destroy:
`HOSTNAME=st2test vagrant destroy`

The alternative is to simply `export HOSTNAME=st2test`

### Logging
This installation makes use of the syslog logging configuration files for each of the St2 components.  You will find the logs in:

    /var/log/st2

All actionrunner processes will be using a combined log under st2actions.log and st2actions.audit.log

### Stay in Touch
Any questions please contact us:

#IRC: Freenode#Stackstorm
# EMAIL: support@stackstorm.com
