FROM php:7.0-apache
LABEL authors="Jeremy Bernard, jeremy@bernard.sh"
LABEL base.image="https://github.com/fr3nd/docker-h5ai"

RUN apt-get update && apt-get install -y \
      imagemagick \
      libav-tools \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng12-dev \
      patch \
      unzip \
      zip \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/* && \
      docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
      docker-php-ext-install gd && \
      docker-php-ext-install exif

ENV H5AI_VERSION 0.29.0

RUN curl -L https://release.larsjung.de/h5ai/h5ai-${H5AI_VERSION}.zip > /usr/src/h5ai-${H5AI_VERSION}.zip && \
    unzip /usr/src/h5ai-${H5AI_VERSION}.zip && \
    rm -f /usr/src/h5ai-${H5AI_VERSION}.zip

# Apache configuration to load HA5I
COPY h5ai.conf /etc/apache2/conf-enabled/h5ai.conf

# H5AI default configuration
RUN ln -s /var/www/html/_h5ai/private/conf /conf

RUN chown www-data:www-data /var/www/html/_h5ai/private/cache
RUN chown www-data:www-data /var/www/html/_h5ai/public/cache


EXPOSE 80
VOLUME /conf