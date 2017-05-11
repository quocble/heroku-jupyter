FROM nvidia/cuda
FROM heroku/heroku:16

MAINTAINER Quoc Le

########## LOAD CONDA ENV ##########

RUN apt-get update
RUN apt-get install -y libatlas-base-dev python-dev gfortran pkg-config libfreetype6-dev
RUN useradd -m app -d /app
USER app

COPY /bin /tools

RUN mkdir -p /tmp/build
COPY environment.yml /tmp/build
RUN /tools/compile /tmp/build /tmp/cache

########## START APP ##########
ENV PORT 5000
ENV JUPYTER_NOTEBOOK_PASSWORD test
ENV JUPYTER_NOTEBOOK_PASSWORD_DISABLED DangerZone!

EXPOSE 5000

WORKDIR /app
ADD . ./
ENTRYPOINT ["./start_jupyter"]
