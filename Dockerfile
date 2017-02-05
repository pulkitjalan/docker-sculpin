FROM ubuntu:14.04
MAINTAINER Pulkit Twine

# Replace shell with bash so we can source files
RUN rm /bin/sh \
    && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    curl \
    zip \
    unzip \
    libssl-dev \
    libfontconfig \
    build-essential \
    wget \
    git-core \
    python-pip \
    jq \
    software-properties-common \
    python-software-properties

# Install aws cli
RUN pip install awscli

# Add repositories
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get update

# Install PHP
ARG PHPVERSION=7.0
RUN apt-get install -y \
    php$PHPVERSION \
    php$PHPVERSION-curl \
    php$PHPVERSION-xml

# Install Composer
ENV COMPOSER_HOME /usr/local/bin/.composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache

# Install Sculpin
RUN curl -sS -O https://download.sculpin.io/sculpin.phar \
    && chmod +x sculpin.phar \
    && mv sculpin.phar /usr/local/bin/sculpin

# Cleanup
RUN apt-get clean \
    && rm -rf ~/* /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && history -c
