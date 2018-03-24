FROM node:latest

USER root
RUN mkdir /haraka
# the application is not started as this user,
# but Haraka can be configured to drop its privileges
# via smtp.ini
RUN groupadd -r haraka && \
    useradd --comment "Haraka Server User" \
            --home /haraka \
            --shell /bin/false \
            --gid haraka \
            -r \
            -M \
            haraka \
    && chown -R haraka:haraka /haraka

COPY run.sh /run.sh
RUN chmod +x /run.sh

USER node
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

RUN npm -g install Haraka



ENTRYPOINT ["/run.sh"]