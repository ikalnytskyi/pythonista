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
* **CPython** - 2.6.9 / 2.7.8 / 3.2.5 / 3.3.5 / 3.4.1
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


Tox & Dox
---------

It's very convenient to run unittests inside Pythonista container with
[tox]. Moreover, there's a tool to do it much easier - [dox].

All you need is just create a `dox.yml` file with next content:

    image: ikalnitsky/pythonista
    commands: tox

and runs `dox` inside your source tree.

[tox]: https://tox.readthedocs.org/
[dox]: https://github.com/stackforge/dox


Feedback
--------

It's important for me to get user's feedback, so please don't hesitate
to suggest improvements or report bugs via [GitHub Issue].

[GitHub Issue]: https://github.com/ikalnitsky/pythonista/issues
