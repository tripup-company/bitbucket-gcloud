FROM php:7.1

RUN apt-get update && apt-get install -y unzip && apt-get install -y libicu-dev \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN export CLOUD_SDK_REPO="cloud-sdk-jessie"; \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \
    apt-get update && apt-get install -y google-cloud-sdk kubectl nodejs build-essential ruby unzip -y;\
    npm install -g sass grunt grunt-cli
