FROM php:5.6-apache
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

RUN apt-get update && apt-get install -y \
      git \
      rrdtool \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/* && \
      docker-php-ext-install json

ENV URL_PREFIX /

RUN a2enmod rewrite
RUN rm -rf /var/www/html
WORKDIR /usr/src
RUN git clone https://github.com/frankhereford/CGP.git  && \
    cd CGP && \
    rm -rf .git
WORKDIR /
COPY config.local.php /usr/src/CGP/conf/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
