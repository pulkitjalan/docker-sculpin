FROM pulkitjalan/composer-npm

# Install sculpin
RUN composer global require dflydev/embedded-composer:@dev \
    && composer global require sculpin/sculpin:@dev \
    && composer clear-cache
