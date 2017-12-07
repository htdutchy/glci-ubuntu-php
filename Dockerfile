# Use the latest Ubuntu LTS image
FROM ubuntu:latest

# Set environment variables
ENV EXTRA_PACKAGES ""
ENV TIMEZONE Europe/Amsterdam

# Prep ubuntu image
RUN export LANG=C.UTF-8 && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common curl wget git && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update

# Install php5.6 with common packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5.6 php5.6-mysql php5.6-xml php5.6-mbstring php5.6-mcrypt php5.6-xdebug php5.6-zip
# Install php7.0 with common packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php7.0 php7.0-mysql php7.0-xml php7.0-mbstring php7.0-mcrypt php7.0-xdebug php7.0-zip
# Install php7.1 with common packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php7.1 php7.1-mysql php7.1-xml php7.1-mbstring php7.1-mcrypt php7.1-xdebug php7.1-zip

# Install extra packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ${EXTRA_PACKAGES}

# Add proper default conf
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Set the working directory
WORKDIR /var/www
