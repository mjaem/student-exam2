FROM alpine:latest

MAINTAINER Mikhail Mjae

#Install python, clone Git repository and install web application

RUN apk update && \
        apk add --no-cache git python3 && \
        cd /root && \
        git clone https://github.com/mjaem/student-exam2.git && \
        cd student-exam2/ && \
        pip3 install -e .

ENV FLASK_APP js_example

CMD flask run --host=0.0.0.0

