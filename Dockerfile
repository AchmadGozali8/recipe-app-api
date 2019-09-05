# very very lighweight minimum image that run python
FROM python:3.7-alpine

# you know what it is
MAINTAINER Ichal

# don't allow python to buffer the output, instead it just print them directly
ENV PYTHONUNBUFFERED 1

# copy file in current dir to drectory on docker image
COPY ./requirements.txt /requirements.txt

# execute command
RUN pip install -r /requirements.txt

# Create directory to docker image
RUN mkdir /app

# set working directroy ( place where our application will be run )
WORKDIR /app

# Copy ./app directory to /app directory on docker image
COPY ./app /app

# Create user to run our docker application (FOR SECURITY PURPOSES)
RUN adduser -D recipe_app

# switch user to newest user already created
USER recipe_app