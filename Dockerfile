#######################################################################
# Dockerfile to built container image for real Pythonistas!
#
# What that means? That means the container includes all popular
# Python interpreters, pip and virtualbox so it very usefull to
# test your software within pythonista container!
#######################################################################

FROM        debian:jessie
MAINTAINER  Igor Kalnitsky  <igor@kalnitsky.org>

# install Python 2.7 and Python 3.4 from official repos
RUN apt-get update
RUN apt-get -y install python2.7-dev
RUN apt-get -y install python3.4-dev


# compile Python 2.6, Python 3.2 and Python 3.3 from sources
ADD get-python.sh  /var/tmp/get-python.sh
RUN chmod +x /var/tmp/get-python.sh

RUN /var/tmp/get-python.sh "https://www.python.org/ftp/python/2.6.8/Python-2.6.8.tgz"
RUN /var/tmp/get-python.sh "https://www.python.org/ftp/python/3.2.5/Python-3.2.5.tgz"
RUN /var/tmp/get-python.sh "https://www.python.org/ftp/python/3.3.5/Python-3.3.5.tgz"
