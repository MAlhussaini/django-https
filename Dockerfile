# Lightwieght OS greate for creating dockerised applications
FROM python:3.10-alpine3.16
# tells python to not buffer the outputs (prints all outputs to the consol)
ENV PYTHONUNBUFFERED 1

# Copy requirements file to the docker image
COPY ./requirements.txt /requirements.txt


# Requuired Alpine <-(OS) packages to install uWSGI server
# apk is the Alpine Pakage manager
# add is for installing new pakage
# --virtual .tmp to install (gcc libc-dev linux-headers) in tmp file
# gcc libc-dev linux-headers only needed to install requirements.txt
RUN apk add --upgrade --no-cache build-base linux-headers && \
    pip install --upgrade pip && \
    pip install -r /requirements.txt

COPY app/ /app
WORKDIR /app

COPY ./scripts /scripts
RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/

RUN adduser --disabled-password --no-create-home django

RUN chown -R django:django /vol
RUN chmod -R 755 /vol/web

USER django

CMD [ "entrypoint.sh" ]
# CMD ["uwsgi","--socket",":9000","--workers","4","--master","--enable-threads","--module","app.wsgi"]