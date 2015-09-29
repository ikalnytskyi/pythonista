#!/usr/bin/env python
# coding: utf-8

"""
    Test suite for the Pythonista Docker image
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Run the following command inside Pythonista container in order to
    check everything inside works as expected:

        $ python path/to/tests.py

    Please note that test cases MUST be changed each time the Python
    interpreter version is changed.

    :copyright: (c) 2015 Igor Kalnitsky
    :license: 3-clause BSD
"""

from __future__ import unicode_literals

import unittest
import subprocess


class TestPyVersions(unittest.TestCase):

    _py_ver = 'import sys; sys.stdout.write("%d.%d.%d" % sys.version_info[:3])'

    def _get_py_version(self, py_interpreter):
        stdout = subprocess.check_output(
            "{0} -c '{1}'".format(py_interpreter, self._py_ver),
            shell=True)
        return stdout.decode('ascii')

    def test_py26(self):
        self.assertEqual('2.6.9', self._get_py_version('python2.6'))

    def test_py27(self):
        self.assertEqual('2.7.10', self._get_py_version('python2.7'))

    def test_py32(self):
        self.assertEqual('3.2.6', self._get_py_version('python3.2'))

    def test_py33(self):
        self.assertEqual('3.3.6', self._get_py_version('python3.3'))

    def test_py34(self):
        self.assertEqual('3.4.3', self._get_py_version('python3.4'))

    def test_py35(self):
        self.assertEqual('3.5.0', self._get_py_version('python3.5'))

    def test_pypy(self):
        self.assertEqual('2.7.10', self._get_py_version('pypy'))

    def test_pypy3(self):
        self.assertEqual('3.2.5', self._get_py_version('pypy3'))

    def test_py2_default(self):
        self.assertEqual('2.7.10', self._get_py_version('python2'))

    def test_py3_default(self):
        self.assertEqual('3.5.0', self._get_py_version('python3'))


class TestSqliteSupport(unittest.TestCase):

    _py_sqlite = 'import sqlite3'

    def _check_sqlite3_support(self, py_interpreter):
        retcode = subprocess.call(
            "{0} -c '{1}'".format(py_interpreter, self._py_sqlite),
            shell=True)
        return retcode

    def test_py26(self):
        self.assertEqual(0, self._check_sqlite3_support('python2.6'))

    def test_py27(self):
        self.assertEqual(0, self._check_sqlite3_support('python2.7'))

    def test_py32(self):
        self.assertEqual(0, self._check_sqlite3_support('python3.2'))

    def test_py33(self):
        self.assertEqual(0, self._check_sqlite3_support('python3.3'))

    def test_py34(self):
        self.assertEqual(0, self._check_sqlite3_support('python3.4'))

    def test_py35(self):
        self.assertEqual(0, self._check_sqlite3_support('python3.5'))

    def test_pypy(self):
        self.assertEqual(0, self._check_sqlite3_support('pypy'))

    def test_pypy3(self):
        self.assertEqual(0, self._check_sqlite3_support('pypy3'))


if __name__ == '__main__':
    unittest.main()
