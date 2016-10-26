#!/bin/bash

# The script is designed to help you download, compile and install
# a given Python interpreter into your system. Sometimes you need
# to test your software in old Python envs and you can't fine it
# in your repo. In that case you have no choice except compile
# Python from the sources.
#
# Usage:
#
#   $ bash ./get-python.sh <py_version>...
#
# Note: the script has a lot of abstract functions because in the
#       future it may be easier to port it to RH-based systems.
#
# Copyright (c) 2014, Igor Kalnitsky <igor@kalnitsky.org>
# Licensed under 3-clause BSD.


# Get distribution name to distinguish between `debian`, `centos`, etc.
OSNAME=$(cat /etc/*-release | grep ^ID= | cut -d'=' -f 2 | tr -d '"')

#
# Define distribution specific package requirements.
#
case ${OSNAME} in

    "debian")
        REQUIREMENTS=(
            "libsqlite3-0"
            "libssl1.0.2"
            "libexpat1"
            "libffi6"
        )

        BUILD_REQUIREMENTS=(
            "wget"
            "build-essential"
            "libsqlite3-dev"
            "libreadline-dev"
            "libssl-dev"
            "zlib1g-dev"
            "libbz2-dev"
            "libncurses5-dev"
            "libffi-dev"
            "libexpat-dev"
        )
        ;;

    "centos")
        REQUIREMENTS=(
            "sqlite"
            "openssl-libs"
            "expat"
            "libffi"
            "python-pip"
        )

        BUILD_REQUIREMENTS=(
            "wget"
            "sqlite-devel"
            "readline-devel"
            "openssl-devel"
            "zlib-devel"
            "bzip2-devel"
            "ncurses-devel"
            "libffi-devel"
            "expat-devel"
        )
        ;;
    *)
        echo "ERROR: Unsupported OS type: ${OSNAME}"
        exit 1
        ;;
esac

#
# A sorf of entry point - download, compile and install given Pythons.
#
function main {
    install_packages "${REQUIREMENTS[@]}"           || exit 1
    install_packages "${BUILD_REQUIREMENTS[@]}"     || exit 1
    install_pyenv                                   || exit 1

    for pyversion in "${@}"; do
        install_python "$pyversion"                 || exit 1
    done

    remove_packages "${BUILD_REQUIREMENTS[@]}"
    clean_packages
}


#
# Install a given packages to the system.
#
# $@ - array of packages to be installed
#
function install_packages {
case ${OSNAME} in
    "debian")
        apt-get update
        apt-get -y install "${@}"
        ;;
    "centos")
        yum upgrade -y
        yum -y install epel-release
        yum -y groupinstall development
        yum -y install "${@}"
        ;;
esac
}


#
# Install and configure the PyEnv tool.
#
function install_pyenv {
    wget https://github.com/yyuu/pyenv/archive/master.tar.gz
    tar -xzf master.tar.gz
    bash pyenv-master/plugins/python-build/install.sh
    rm -rf pyenv-master/ master.tar.gz
}


#
# Install a given Python interpreter version.
#
# $1 - a Python interpreter version
#
function install_python {
    echo "export PATH=\"\$PATH:/opt/python/$1/bin/\"" >> /etc/profile.d/pythonista.sh
    PYTHON_CONFIGURE_OPTS="--enable-shared" CFLAGS="-g -O2" python-build "$1" "/opt/python/$1"
}

#
# Remove given packages from the system.
#
# $@ - array of packages to be removed
#
function remove_packages {
    case ${OSNAME} in
        "debian")
            apt-get -y purge --auto-remove "${@}"
            apt-get -y autoremove
            ;;
        "centos")
            yum -y erase "${@}"
            yum -y autoremove
            ;;
    esac
}

#
# Remove unused packages.
#
function clean_packages {
    case ${OSNAME} in
        "debian")
            apt-get autoclean
            apt-get clean
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
            ;;
        "centos")
            yum -y clean all
            ;;
    esac
}


main "${@}"
