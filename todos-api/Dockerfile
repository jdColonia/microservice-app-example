FROM node:8.17.0-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install && npm cache clean --force

COPY . .

ENV TODO_API_PORT=3000 \
    JWT_SECRET=PRFT \
    REDIS_HOST=redis \
    REDIS_PORT=6379 \
    REDIS_CHANNEL=log_channel

EXPOSE 3000
CMD ["npm", "start"]