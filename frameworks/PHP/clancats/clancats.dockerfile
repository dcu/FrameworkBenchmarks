FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yqq && apt-get install -yqq software-properties-common > /dev/null
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -yqq  > /dev/null
RUN apt-get install -yqq nginx git unzip php5.6 php5.6-common php5.6-cli php5.6-fpm php5.6-mysql php5.6-xml php5.6-mbstring php5.6-mcrypt  > /dev/null

RUN apt-get install -yqq composer > /dev/null

COPY deploy/conf/* /etc/php/5.6/fpm/
RUN sed -i "s|listen = /run/php/php7.2-fpm.sock|listen = /run/php/php5.6-fpm.sock|g" /etc/php/5.6/fpm/php-fpm.conf

ADD ./ /clancats
WORKDIR /clancats

RUN composer install --quiet

RUN git clone --branch v2.0.6 --depth 1 https://github.com/ClanCats/Framework.git clancatsapp
RUN cp -r app/ clancatsapp/CCF/
RUN cp -r vendor/ clancatsapp/CCF/

CMD service php5.6-fpm start && \
    nginx -c /clancats/deploy/nginx.conf -g "daemon off;"
