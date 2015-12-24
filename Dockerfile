#######################################################################
# Dockerfile for building Pythonista docker image.
#
# Copyright (c) 2014, Igor Kalnitsky <igor@kalnitsky.org>
# Licensed under 3-clause BSD
#
# See https://github.com/ikalnitsky/pythonista for details.
#######################################################################

FROM        debian:stretch
MAINTAINER  Igor Kalnitsky <igor@kalnitsky.org>

ADD get-python.sh  /var/tmp/get-python.sh

# Install CPython interpreters.
#
# NOTE: We're going to install 2.7 and 3.5 first because we want to
#       make more rational defaults for pip and python.
RUN ["/bin/bash", "/var/tmp/get-python.sh", \
     "2.7.10", \
     "3.5.0", \
     "2.6.9", \
     "3.3.6", \
     "3.4.3", \
     "pypy-portable-4.0", \
     "pypy3-portable-2.4"]

# Unfortunately, there's no way (at least I don't know one) to
# change PATH variable inside container. The only way I know is
# to setup it directly in Dockerfile, but it's awful when the
# PATH should be changed dynamically based on some third-party
# input. But I have no choice... :(
ENV PYTHONBIN $PYTHONBIN:/opt/python/2.7.10/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/3.5.0/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/2.6.9/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/3.3.6/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/3.4.3/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/pypy-portable-4.0/bin
ENV PYTHONBIN $PYTHONBIN:/opt/python/pypy3-portable-2.4/bin
ENV PATH $PYTHONBIN:$PATH

# Install first-class tools
RUN pip install tox virtualenv
