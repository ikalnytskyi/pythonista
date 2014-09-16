#######################################################################
# Dockerfile for building Pythonista docker image.
#
# Copyright (c) 2014, Igor Kalnitsky <igor@kalnitsky.org>
# Licensed under 3-clause BSD
#
# See https://github.com/ikalnitsky/pythonista for details.
#######################################################################

FROM        debian:jessie
MAINTAINER  Igor Kalnitsky <igor@kalnitsky.org>

ADD get-python.sh  /var/tmp/get-python.sh

# Install Python interpreters.
#
# NOTE: We want to install 2.7 and 3.4 first because we want to
#       make more rational default for pip and python.
RUN ["/bin/bash", "/var/tmp/get-python.sh", \
     "2.7.8", \
     "3.4.1", \
     "2.6.9", \
     "3.1.5", \
     "3.2.5", \
     "3.3.5"]

# Unfortunately, there's no way (at least I don't know one) to
# change PATH variable inside container. The only way I know is
# to setup it directly in Dockerfile, but it's awful when the
# PATH should be changed dynamically based on some third-party
# input. But I have no choice... :(
ENV PATH $PATH:/opt/python/2.7.8/bin
ENV PATH $PATH:/opt/python/3.4.1/bin
ENV PATH $PATH:/opt/python/2.6.9/bin
ENV PATH $PATH:/opt/python/3.1.5/bin
ENV PATH $PATH:/opt/python/3.2.5/bin
ENV PATH $PATH:/opt/python/3.3.5/bin

# Install first-class tools
RUN pip install tox virtualenv
