FROM ubuntu:xenial

LABEL maintainer="nginx Docker Maintainers <gary@quinn.co.za>"

USER root

RUN apt-get update \
    && apt-get -y install wget git \
    && apt-get -y install build-essential \
    && apt-get -y install libpcre3 libpcre3-dev libpcrecpp0v5 libssl-dev \
    && apt-get -y install libssl-dev \
    && apt-get -y install zlib1g-dev \
    && apt-get -y install libldap2-dev \
    && mkdir -p /working \
    && cd /working \
    && git clone https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng.git \
    && git clone https://github.com/kvspb/nginx-auth-ldap.git \
    && git clone https://github.com/openresty/headers-more-nginx-module.git \
    && wget http://nginx.org/download/nginx-1.15.7.tar.gz \
    && tar -zxvf nginx-1.15.7.tar.gz \
    && cd nginx-1.15.7 \
    && ./configure \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --with-debug \
        --with-pcre \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_stub_status_module \
        --add-module=/working/nginx-sticky-module-ng \
        --add-module=/working/nginx-auth-ldap \
        --add-module=/working/headers-more-nginx-module \
    && make \
    && make install

COPY app.sh /app.sh

ENTRYPOINT [ "bash", "-c", "/app.sh" ]
