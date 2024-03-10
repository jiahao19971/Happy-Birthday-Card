FROM node:18-alpine3.18 as builder
WORKDIR /app

ARG NAME
ARG PIC
ARG NICKNAME
ARG SCROLL_MSG
ARG HBD_MSG
ARG OPEN_DATE

RUN echo "NAME='$NAME'" >> .env
RUN echo "PIC='$PIC'" >> .env
RUN echo "NICKNAME='$NICKNAME'" >> .env
RUN echo "SCROLL_MSG='$SCROLL_MSG'" >> .env
RUN echo "HBD_MSG='$HBD_MSG'" >> .env
RUN echo "OPEN_DATE='$OPEN_DATE'" >> .env

COPY . .
RUN npm install 
RUN npm run init-index-local
RUN npm run build:parcel

FROM node:18-alpine3.18 as deploy
WORKDIR /app
RUN npm install -g live-server
COPY --from=builder /app/dist .

EXPOSE 8080 
CMD ["live-server"]