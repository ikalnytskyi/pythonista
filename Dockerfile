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

# install Python 2.7 and Python 3.4 from official repos
RUN apt-get update
RUN apt-get -y install python2.7-dev
RUN apt-get -y install python3.4-dev


# compile Python 2.6, Python 3.2 and Python 3.3 from sources
ADD get-python.sh  /var/tmp/get-python.sh

RUN ["/bin/bash", "/var/tmp/get-python.sh", \
        "https://www.python.org/ftp/python/2.6.8/Python-2.6.8.tgz", \
        "https://www.python.org/ftp/python/3.2.5/Python-3.2.5.tgz", \
        "https://www.python.org/ftp/python/3.3.5/Python-3.3.5.tgz"]
