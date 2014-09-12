#!/bin/bash

# The script is designed to install a given Python interpreter in
# the system. Sometimes you need to test your software using old
# Python interpreter and you can't find it in the repository. In
# that case the script will help you to download, compile and
# install old Python versions in the system.
#
# Copyright (c) 2014 by Igor Kalnitsky <igor@kalnitsky.org>
# Licensed under 3-clause BSD.
#

PYTHON_SOURCES=(
    "https://www.python.org/ftp/python/2.6.8/Python-2.6.8.tgz"
    "https://www.python.org/ftp/python/3.2.5/Python-3.2.5.tgz"
    "https://www.python.org/ftp/python/3.3.5/Python-3.3.5.tgz"
)


DEB_REQUIREMENTS=(
    "wget"
    "tar"
    "gcc"
    "make"
)


#
# A sorf of entry point - download, compile and install given Pythons.
#
function main {
    install_packages "${DEB_REQUIREMENTS[@]}"

    for download_url in ${PYTHON_SOURCES[@]}; do
        local tarball=`basename $download_url`
        local source_=`basename $tarball .tgz`

        download    $download_url
        unpack      $tarball
        compile     $source_
        install     $source_

        rm -rf $download_url $tarball $source_
    done
}

#
# Install a given packages to the system.
#
# $@ - array of packages to be installed
#
function install_packages {
    apt-get -y install "${@}"
}


#
# Download a given remote file.
#
# $1 - a URL to file to be downloaded
#
function download {
    wget $1
}


#
# Unpack a given tarball to the folder with a same name.
#
# $1 - a path to the tarball to be unpacked
#
function unpack {
    tar -xzf $1
}


#
# Compile Python interpreter from a given sources.
#
# $1 - a path to python sources
#
function compile {
    pushd $1
        ./configure
        make
    popd
}


#
# Install Python interpreter from a given folder.
#
# $1 - a path to compiled sources
#
function install {
    pushd $1
        make install
    popd
}


main
