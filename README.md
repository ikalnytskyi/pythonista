Pythonista - the Docker image
=============================

Pythonista is a [Docker] image for real Python developers. That means
you can find here most popular Python interpreters and tests your
application in all of them. The idea for image was born when I needed
to test some code in Python 2.6 environment and my workstation couldn't
handle it, since Debian Jessie doesn't have Python 2.6 in its repo.

[Docker]: https://docker.com/


About Image
-----------

* **OS** - Debian Jessie (Testing)
* **CPython** - 2.6.9 / 2.7.10 / 3.2.6 / 3.3.6 / 3.4.3
* **PyPy** - PyPy 2.6.0 (based on 2.7.9) / PyPy3 2.4.0 (based on 3.2.5)
* **Env** - pip, virtualenv, tox


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


Feedback
--------

It's important for me to get user's feedback, so please don't hesitate
to suggest improvements or report bugs via [GitHub Issue].

[GitHub Issue]: https://github.com/ikalnitsky/pythonista/issues
