# very very lighweight minimum image that run python
FROM python:3.7-alpine

# you know what it is
MAINTAINER Ichal

# don't allow python to buffer the output, instead it just print them directly
ENV PYTHONUNBUFFERED 1

# copy file in current dir to drectory on docker image
COPY ./requirements.txt /requirements.txt

# install PostgresSQL client
RUN apk add --update --no-cache postgresql-client jpeg-dev

# install temporary packages
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

# execute command
RUN pip install -r /requirements.txt

# delete temporary requirement
RUN apk del .tmp-build-deps

# Create directory to docker image
RUN mkdir /app

# set working directroy ( place where our application will be run )
WORKDIR /app

# Copy ./app directory to /app directory on docker image
COPY ./app /app

# Create directory to store media files
RUN mkdir -p /vol/web/media

# Create directory to store static files
RUN mkdir -p /vol/web/static

# Create user to run our docker application (FOR SECURITY PURPOSES)
RUN adduser -D recipe_app

# Change owner directory
RUN chown -R recipe_app:recipe_app /vol/

# Add permission
RUN chmod -R 755 /vol/web

# switch user to newest user already created
USER recipe_app