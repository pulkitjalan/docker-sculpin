FROM pulkitjalan/composer-npm

# Install sculpin
RUN composer global require sculpin/sculpin:@stable \
    && composer clear-cache
