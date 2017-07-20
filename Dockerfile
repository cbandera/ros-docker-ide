# ROS Kinetic IDE docker environment
FROM osrf/ros:jade-desktop-full
MAINTAINER Claudio Bandera <cbandera@posteo.de>

# Install additonal 
RUN apt-get update
RUN env DEBIAN_FRONTEND=noninteractive \
	apt-get upgrade -y
RUN env DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    tmux \
    ca-certificates \
    curl \
    software-properties-common \
    build-essential \
    python-catkin-tools

# Newest compiler    
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN env DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    gcc-4.9 g++-4.9 
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

# Gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

# Install Catkin Tools

# Create User
RUN echo "root:Docker!" | chpasswd
RUN useradd --shell /bin/bash -c "" --create-home claudio


# Startup
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]