Pythonista - the Docker image
=============================

Pythonista is a [Docker] image for real Python developers. That means
you can find here most popular Python interpreters and test your
application in all of them. The idea for the image was born when I needed
to test some code in Python 2.6 environment and my workstation couldn't
handle it, since Debian Jessie doesn't have Python 2.6 in its repo.

[Docker]: https://docker.com/


About Image
-----------

* **OS** - Debian 9 Stretch (testing) or CentOS 7
* **CPython** - 2.6.9 / 2.7.11 / 3.3.6 / 3.4.4 / 3.5.1
* **PyPy** - PyPy 4.0.1 (based on 2.7.10) / PyPy3 2.4.0 (based on 3.2.5)


How To Use?
-----------

Pythonista image is available on [Docker Hub], so you can easily `pull`
it by means `docker` client:

    $ [sudo] docker pull ikalnitsky/pythonista

If you want to enter a bash session, just do it how you did it for
another containers:

    $ [sudo] docker run -t -i ikalnitsky/pythonista bash

and enjoy `bash` session within container.

[Docker Hub]: https://hub.docker.com/


Unit Tests
----------

It's very convenient to run unit tests inside Pythonista container because
you can run it using different Python interpreters. For example, with [tox]
the command might look like:

    $ [sudo] docker run -v /path/to/src/:/src -w /src ikalnitsky/pythonista tox

[tox]: https://tox.readthedocs.org/


Build the image locally
-----------------------

You are also welcome to build and tweak the testing image locally using
provided Dockerfiles.

To build Pythonista Docker image (by default based on **Debian**):

    $ [sudo] docker build -t pythonista-deb .

To build Pythonista Docker image based on **CentOS** use `Dockerfile.centos`:

    $ [sudo] docker build -f Dockerfile.centos -t pythonista-yum .


Feedback
--------

It's important for me to get user's feedback, so please don't hesitate
to suggest improvements or report bugs via [GitHub Issue].

[GitHub Issue]: https://github.com/ikalnitsky/pythonista/issues
