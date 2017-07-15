# Use an official Python runtime as a parent image
FROM ubuntu:latest

# Set environment variables
## PHP Version (php5.6, php7.0 php7.1)
ENV PHP php7.1
ENV EXTRA_PACKAGES php7.1-xml php7.1-mbstring php7.1-mcrypt php7.1-xdebug
ENV PRE_PACKAGES ""
ENV TIMEZONE Europe/Amsterdam

# Prep ubuntu image
RUN export LANG=C.UTF-8 && \
    export DEBIAN_FRONTEND=noninteractive && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apt-get -y update && \
    apt-get -y install software-properties-common git && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update

# Install other packages
RUN apt-get -y install ${PRE_PACKAGES}
# Install php common
RUN apt-get -y install ${PHP}-common
# Install extra (php) packages
RUN apt-get -y install ${EXTRA_PACKAGES}

# Add proper default conf
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Set the working directory
WORKDIR /var/www
