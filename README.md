st2express
==========

This repo contains artifacts to spin up st2 Docker and Vagrant images and play around with st2. 
Please look at individual README.md for more instructions. 

Once the images are spun up:

You can see the action list via:

    st2 action list

The supervisor script to start,stop,restart,reload, and, clean st2 is run like so:

    st2ctl start|stop|status|restart|reload|clean

### Logging
This installation makes use of the syslog logging configuration files for each of the St2 components.  You will find the logs in:

    /var/log/st2

All actionrunner processes will be using a combined log under st2actions.log and st2actions.audit.log

### Stay in Touch
Any questions please contact us:

#IRC: Freenode#Stackstorm
# EMAIL: support@stackstorm.com
