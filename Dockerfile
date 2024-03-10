FROM node:18-alpine3.18 as builder
WORKDIR /app
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