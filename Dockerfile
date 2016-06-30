FROM resin/rpi-raspbian:jessie
MAINTAINER rcjcooke

# Check to see if Raspbian needs updating, update it and cleanout the apt-get cache afterwards
# to keep image size down
RUN apt-get update && apt-get dist-upgrade && apt-get clean

# Copy across the camera interface and install it
COPY RPi_Cam_Web_Interface /usr/local/RPi_Cam_Web_Interface

WORKDIR /usr/local/RPi_Cam_Web_Interface
RUN chmod u+x *.sh \
	&& ./install.sh q
# TODO: Check to see whether we can remove the directory after install

# RPi Cam Web Interface listens on port 80
EXPOSE 80

ENTRYPOINT ["/usr/local/RPi_Cam_Web_Interface/start.sh"]
