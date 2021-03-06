FROM lsiobase/nginx:3.11
# set version label
ARG BUILD_DATE
ARG VERSION
ARG TT_RSS_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Tony M. <tonyroomz@gmail.com>"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	git \
	grep \
	php7-apcu \
	php7-curl \
	php7-dom \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-ldap \
	php7-mcrypt \
	php7-mysqli \
	php7-mysqlnd \
	php7-pcntl \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pgsql \
	php7-posix  && \
 echo "**** install software ****" && \
 git clone --branch master --depth 1 https://git.tt-rss.org/fox/tt-rss.git /var/www/html && \
 git clone --branch master --depth 1 https://git.tt-rss.org/fox/ttrss-nginx-xaccel.git /var/www/html/plugins.local/nginx_xaccel && \
 echo "**** link php7 to php ****" && \
 ln -sf /usr/bin/php7 /usr/bin/php && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
