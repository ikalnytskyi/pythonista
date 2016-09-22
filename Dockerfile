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
     "2.7.12", \
     "3.5.2", \
     "3.3.6", \
     "3.4.5", \
     "pypy-portable-5.4.1", \
     "pypy3-portable-2.4"]

# Unfortunately, there's no way (at least I don't know one) to
# change PATH variable inside container. The only way I know is
# to setup it directly in Dockerfile, but it's awful when the
# PATH should be changed dynamically based on some third-party
# input. But I have no choice... :(
#
# Also, I use one ENV statement in order to avoid creation of
# unneccessary extra Docker layers.
ENV PATH /opt/python/2.7.12/bin\
:/opt/python/3.5.2/bin\
:/opt/python/3.3.6/bin\
:/opt/python/3.4.5/bin\
:/opt/python/pypy-portable-5.4.1/bin\
:/opt/python/pypy3-portable-2.4/bin\
:$PATH

# Install first-class tools
RUN pip install tox virtualenv
