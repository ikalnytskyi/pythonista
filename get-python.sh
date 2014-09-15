#!/bin/bash

# The script is designed to help you download, compile and install
# a given Python interpreter into your system. Sometimes you need
# to test your software in old Python envs and you can't fine it
# in your repo. In that case you have no choice except compile
# Python from the sources.
#
# Usage:
#
#   $ bash ./get-python.sh <url-to-tgz>
#
# Copyright (c) 2014, Igor Kalnitsky <igor@kalnitsky.org>
# Licensed under 3-clause BSD.

DEB_BUILD_REQUIREMENTS=(
    "wget"
    "gcc"
    "make"
    "zlib1g-dev"
    "libsqlite3-dev"
    "libreadline-dev"
    "libssl-dev"
    "liblzma-dev"
)


#
# A sorf of entry point - download, compile and install given Pythons.
#
function main {
    install_packages "${DEB_BUILD_REQUIREMENTS[@]}"

    for download_url in ${@}; do
        local tarball=`basename $download_url`
        local source_=`basename $tarball .tgz`

        download    $download_url
        unpack      $tarball
        compile     $source_
        install     $source_

        rm -rf $download_url $tarball $source_
    done

    remove_packages "${DEB_BUILD_REQUIREMENTS[@]}"
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
# Remove a given packages from the system.
#
# $@ - array of packages to be removed
#
function remove_packages {
    apt-get -y purge "${@}"
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


main ${@}
