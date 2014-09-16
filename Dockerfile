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
RUN ["/bin/bash", "/var/tmp/get-python.sh", "2.6.9", "2.7.8", "3.4.1", "3.1.5", "3.2.5", "3.3.5"]

# Install usefull tools
RUN pip2.7 install tox virtualenv
