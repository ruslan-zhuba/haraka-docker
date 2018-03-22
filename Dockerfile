FROM node:latest

USER node
WORKDIR /usr/src/app
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

RUN npm -g install Haraka
USER root
RUN mkdir /haraka

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]