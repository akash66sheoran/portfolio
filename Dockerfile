FROM python:3.9

WORKDIR /app

RUN pip install flask
RUN pip install gunicorn

COPY . /app

EXPOSE 80

CMD gunicorn -b 0.0.0.0:80 --log-file gunicorn.log app:app
