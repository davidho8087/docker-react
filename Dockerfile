FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# docker run -p 8080:80 317c19bf4b44