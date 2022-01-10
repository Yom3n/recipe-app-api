FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHON_PIP_VERSION 19.1.1


COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev

# temporarily install dependencies needed only to install postgresql
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN pip install -r /requirements.txt

# delete temp dependencies only needed to install postgres
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# For security:
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user