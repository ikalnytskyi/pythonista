Pythonista - the Docker image
=============================

Pythonista is a [Docker] image for real Python developers. That means
you can find here most popular Python interpreters and tests your
application in all of them.

The idea for image was born when I needed to test some code in Python 2.6
environment and my workstation couldn't handle it, since Debian Jessie
doesn't have Python 2.6 in the repository.


How To Use?
-----------

Pythonista image is available on [Docker Hub], so you can easily `pull`
it by means `docker` client:

    $ [sudo] docker pull ikalnitsky/pythonista

If you want to enter a bash session, just do it how you did it for
another containers:

    $ [sudo] docker run -t -i ikalnitsky/pythonista bash

and enjoy `bash` session within container.


Dox
---

It's very convenient to run unittests inside Pythonista container with
[tox]. Moreover, there's a tool to doing it much easier - [dox].

All you need is just create a `dox.yml` file with next content:

    image: ikalnitsky/pythonista
    commands: tox

and runs `dox` inside your source tree.


Technical Specification
-----------------------

| Thing            | Status                                |
|:----------------:|:-------------------------------------:|
| Operating System | Debian Jessie (Testing)               |
| CPython Versions | 2.6.8 / 2.7.8 / 3.2.5 / 3.3.5 / 3.4.1 |


[Docker]:       https://docker.com/
[Docker Hub]:   https://hub.docker.com/
[tox]:          https://tox.readthedocs.org/
[dox]:          https://github.com/stackforge/dox
