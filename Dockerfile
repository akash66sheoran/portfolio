FROM python:3.9

WORKDIR /app

RUN pip install flask
RUN pip install gunicorn

COPY . /app

EXPOSE 5000

CMD gunicorn -b 0.0.0.0:5000 --log-file gunicorn.log app:app
