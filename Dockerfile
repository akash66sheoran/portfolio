FROM python:3.9

WORKDIR /app

RUN pip install flask
RUN pip install gunicorn

COPY . /app

EXPOSE 80
EXPOSE 443

RUN apt update && apt install -y certbot

CMD ["gunicorn", "--certfile=/etc/letsencrypt/live/akashsheoran.com/fullchain.pem", "--keyfile=/etc/letsencrypt/live/akashsheoran.com/privkey.pem", "-b", "0.0.0.0:443", "app:app"]
