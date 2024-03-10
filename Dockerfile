FROM node:18-alpine3.18 as builder
WORKDIR /app

RUN apk update && apk add bash

COPY . .
RUN npm install 
RUN npm install -g live-server

EXPOSE 8080 

CMD [ "npm", "run", "watch" ]