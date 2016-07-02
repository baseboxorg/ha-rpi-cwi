FROM jritsema/rpi-node-piuserland
MAINTAINER rcjcooke

# Copy across the camera interface and install it
COPY RPi_Cam_Web_Interface /usr/local/RPi_Cam_Web_Interface

WORKDIR /usr/local/RPi_Cam_Web_Interface
RUN chmod u+x *.sh \
	&& ./install.sh q
# TODO: Check to see whether we can remove the directory after install

# RPi Cam Web Interface listens on port 80
EXPOSE 80

# Needs to be run with --device /dev/vchiq for access to the camera device
ENTRYPOINT ["/usr/local/RPi_Cam_Web_Interface/start.sh"]
