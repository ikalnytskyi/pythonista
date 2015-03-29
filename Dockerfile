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

# Install CPython interpreters.
#
# NOTE: We're going to install 2.7 and 3.4 first because we want to
#       make more rational defaults for pip and python.
RUN ["/bin/bash", "/var/tmp/get-python.sh", \
     "2.7.9",             \
     "3.4.3",             \
     "2.6.9",             \
     "3.2.6",             \
     "3.3.6",             \
     "pypy-portable-2.5", \
     "pypy3-portable-2.4" ]

# Unfortunately, there's no way (at least I don't know one) to
# change PATH variable inside container. The only way I know is
# to setup it directly in Dockerfile, but it's awful when the
# PATH should be changed dynamically based on some third-party
# input. But I have no choice... :(
ENV PATH $PATH:/opt/python/2.7.9/bin
ENV PATH $PATH:/opt/python/3.4.3/bin
ENV PATH $PATH:/opt/python/2.6.9/bin
ENV PATH $PATH:/opt/python/3.2.6/bin
ENV PATH $PATH:/opt/python/3.3.6/bin
ENV PATH $PATH:/opt/python/pypy-portable-2.5/bin
ENV PATH $PATH:/opt/python/pypy3-portable-2.4/bin

# Install first-class tools
RUN pip install tox virtualenv
