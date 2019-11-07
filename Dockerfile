FROM php:7.2

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN export CLOUD_SDK_REPO="cloud-sdk-jessie"; \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
	
RUN apt-get update && apt-get install -y \
    google-cloud-sdk kubectl nodejs build-essential ruby unzip \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev libicu-dev zlib1g-dev libzip-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && npm install -g sass grunt grunt-cli

