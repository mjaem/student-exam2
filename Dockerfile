FROM alpine:latest

MAINTAINER Mikhail Mjae

RUN mkdir /home/student-exam2
ADD . /home/student-exam2
WORKDIR /home/student-exam2

#Install python and web application 

RUN apk update && \
        apk add --no-cache python3 && \
        pip3 install -e .

ENV FLASK_APP js_example

CMD flask run --host=0.0.0.0

