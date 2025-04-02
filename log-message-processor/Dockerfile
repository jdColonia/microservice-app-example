FROM python:3.6-alpine 
WORKDIR /app

RUN apk add --no-cache --virtual .build-deps gcc musl-dev

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN apk del .build-deps

COPY . .

ENV REDIS_HOST=redis \
    REDIS_PORT=6379 \
    REDIS_CHANNEL=log_channel

CMD ["python", "main.py"]