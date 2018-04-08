#!/bin/bash

# For docker hub downloads
cp /RPi_Cam_Web_Interface/bin/raspimjpeg /opt/vc/bin/
chmod 755 /opt/vc/bin/raspimjpeg

# Start camera interface
/RPi_Cam_Web_Interface/start.sh

# Start Apache
/usr/sbin/apache2ctl -D FOREGROUND
