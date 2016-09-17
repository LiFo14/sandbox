FROM debian
MAINTAINER Nick <cyberdak095@gmail.com>

# install java

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN apt-get install oracle-java8-installer -y


# install necessary utilities

RUN apt-get install -y x11-apps gtk2.0 sudo --fix-missing

# install inotify-tools

RUN apt-get install inotify-tools -y


RUN apt-get clean


# add user, set up  sudo and passwd

RUN if ! id $USER >/dev/null 2>&1; then adduser nick; fi
RUN usermod -a -G sudo $USER
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
