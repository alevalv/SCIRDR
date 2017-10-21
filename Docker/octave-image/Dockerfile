FROM ubuntu:16.04
MAINTAINER alejandrovaldes@live.com

ENV DEBIAN_FRONTEND noninteractive

ADD install.sh install.sh
RUN sh ./install.sh && rm install.sh
RUN useradd -ms /bin/bash octave
RUN chown -R octave:octave /home/octave/

USER octave
WORKDIR /home/octave
