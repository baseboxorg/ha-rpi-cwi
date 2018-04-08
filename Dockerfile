FROM resin/raspberry-pi2-debian:jessie

# Check to see if Raspbian needs updating, update it and cleanout the apt-get cache afterwards
# to keep image size down
RUN apt-get update && apt-get dist-upgrade && apt-get clean

###### This section lifted from jritsema/rpi-node-piuserland. Original not used
# as it restricts to a specific version of raspbian - will revisit this later
# once I've established which version I can get this to work for!

# build raspberry pi userland tools from source (allows access to gpu, camera, etc.)
RUN apt-get update && apt-get install -y \
      build-essential \
      cmake \
      curl \
			ca-certificates \
      git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd \
      && git clone --depth 1 https://github.com/raspberrypi/userland.git \
      && cd userland \
      && ./buildme

# add raspistill to path
ENV PATH /opt/vc/bin:/opt/vc/lib:$PATH

# update library path (to get past: raspistill: error while loading shared libraries: libmmal_core.so: cannot open shared object file: No such file or directory)
ADD 00-vmcs.conf /etc/ld.so.conf.d/
RUN ldconfig

###### End of Userland install section


# Install Apache
RUN apt-get update && apt-get install -y \
			apache2 \
			php5 \
			libapache2-mod-php5 \
		&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd \
      && git clone https://github.com/silvanmelchior/RPi_Cam_Web_Interface.git \
      /usr/local/RPi_Cam_Web_Interface

WORKDIR /usr/local/RPi_Cam_Web_Interface

RUN chmod u+x *.sh \
	&& ./install.sh q

# RPi Cam Web Interface listens on port 80
EXPOSE 80

COPY entrypoint.sh /usr/local/RPi_Cam_Web_Interface/entrypoint.sh
RUN chmod u+x entrypoint.sh

# Needs to be run with --device /dev/vchiq for access to the camera device
ENTRYPOINT ["/usr/local/RPi_Cam_Web_Interface/entrypoint.sh", "-D", "FOREGROUND"]
