# syntax=docker/dockerfile:1
FROM ubuntu:23.10
# Update and upgrade--> Operating System and TZ
RUN apt-get update
RUN apt-get upgrade -y
ENV TZ=America/Bogota
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata
# Install--> python3, pip package manager and virtualenv
RUN apt-get install -y python3 python3-pip python3-virtualenv
# Create--> Python3 virtualenv
ENV VIRTUAL_ENV=/opt/SARA/
RUN python3 -m virtualenv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# Install--> jam-py package
RUN python3 -m pip install jam.py
# Create SARA jam-project
WORKDIR /opt/SARA
COPY . /opt/SARA/
# Run SARA Python Application
ENTRYPOINT [ "/opt/SARA/bin/python3", "server.py"]