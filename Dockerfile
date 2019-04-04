FROM debian:9

LABEL maintainer="pawel.chudzik@gmail.com"

RUN apt-get update
RUN apt-get -q -y install wget

WORKDIR /tmp
RUN wget -q -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.tar.gz
RUN tar xf hugo.tar.gz
RUN mv hugo /bin/


RUN mkdir /dist

RUN echo '#!/bin/sh \n\
rm -rf /dist/*' > /bin/cleanup

RUN echo '#!/bin/sh \n\
/bin/cleanup \n\
/bin/hugo serve --bind 0.0.0.0 -D -F -E -d /dist \n' > /bin/serve

RUN echo '#!/bin/sh \n\
/bin/cleanup \n\
/bin/hugo -d /dist\n' > /bin/build


RUN chmod +x \
	/bin/serve \
	/bin/build \
	/bin/cleanup

WORKDIR /site

EXPOSE 1313
VOLUME /site
VOLUME /dist
