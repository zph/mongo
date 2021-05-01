FROM debian:stable

RUN apt-get update && apt-get install -y git

RUN git clone --branch r3.4.9 --single-branch https://github.com/evanlimanto/mongo
RUN cd mongo && git checkout r3.4.9

RUN echo "deb [trusted=yes] http://archive.debian.org/debian jessie main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
  scons \
  build-essential

RUN apt-get install -y \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-thread-dev \
  libboost-iostreams-dev

RUN g++ --version
RUN cd mongo && SCONSFLAGS="-j 4" scons --use-system-boost --disable-warnings-as-errors
