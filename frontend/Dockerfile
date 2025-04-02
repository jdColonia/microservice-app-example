FROM node:8.17.0-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN apk add --no-cache --virtual .gyp python make g++ \
  && npm install \
  && apk del .gyp
COPY . .
RUN npm run build

FROM nginx:stable-alpine as production-stage
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/dist /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html && \
  chmod -R 755 /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
