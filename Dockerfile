FROM python:3.9

WORKDIR /app

RUN pip install flask

COPY . /app

EXPOSE 5000

CMD flask run
