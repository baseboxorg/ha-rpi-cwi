#!/bin/bash

# Start camera interface
/usr/local/RPi_Cam_Web_Interface/start.sh

# Start Apache
/usr/sbin/apache2ctl "$@"
