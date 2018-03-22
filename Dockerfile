FROM node:latest

RUN npm install haraka
RUN haraka -i /haraka

CMD ["haraka", "-c", "/haraka"]