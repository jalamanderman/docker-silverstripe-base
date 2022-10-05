FROM brettt89/silverstripe-web:7.4-apache

# replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh
SHELL [ "/bin/bash", "-l", "-c" ]

ENV BASH_ENV "~/.bashrc"

# Make folder for jre install
RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils\
    build-essential\
    dos2unix\
    default-mysql-client \
    libfontconfig1 \
    libxrender1 \
    locales \
    unzip \
    wget \
    zip \
    vim \
    nano \
    rsync \
    git \
    apt-transport-https \
    lsb-release \
    software-properties-common \
    default-jre \
    openssh-client \
    ; apt-get purge -y --auto-remove \
    ; rm -rf /var/lib/apt/lists/*


#
# Install composer and sspak
#
RUN curl -sS https://silverstripe.github.io/sspak/install | php -- /usr/local/bin
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#Make sure compose downloads via https (speed increase)
RUN composer config --global repo.packagist composer https://packagist.org

RUN curl --location --output /usr/local/bin/mhsendmail --silent https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail

RUN echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@localhost.dev"' > /usr/local/etc/php/conf.d/mailhog.ini

## php settings
RUN docker-php-ext-install calendar && docker-php-ext-configure calendar
RUN echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;
RUN echo 'max_execution_time = 300' >> /usr/local/etc/php/conf.d/docker-php-maxexectime.ini;
RUN echo 'upload_max_filesize = 12M' >> /usr/local/etc/php/conf.d/docker-php-maxfile.ini;
RUN echo 'post_max_size = 12M' >> /usr/local/etc/php/conf.d/docker-php-maxfile.ini;

# Install additional extensions
RUN install-php-extensions xdebug

RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=MYIDE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#
# Supply a default .env file
#
# COPY resources/conf/.env /var/www/

#
# Add scripts and configuration
#
COPY resources/scripts/entrypoint.sh /

#
# Fix Windows line endings
#
RUN dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

#
# Modify permissions
#
RUN chmod 755 /entrypoint.sh;

#
# Create docker dev user for running terminal commands eg npm
#
RUN useradd -G www-data,root -u 1000 -d /home/docker-dev docker-dev
RUN mkdir -p /home/docker-dev/.composer && \
    chown -R docker-dev:docker-dev /home/docker-dev

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt install -y --no-install-recommends nodejs \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

# Copy current directory (website) directly to /var/www/html
#     This can sometimes provide a performance improvement over mounting with volumes.
# COPY . /var/www/html/

#
# Entry point
#
CMD ["/entrypoint.sh"]
