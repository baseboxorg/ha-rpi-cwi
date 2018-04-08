#!/bin/bash

# Start camera interface
/RPi_Cam_Web_Interface/start.sh

# Start Apache
/usr/sbin/apache2ctl "$@"
