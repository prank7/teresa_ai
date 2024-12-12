#!/bin/bash

# Install latest SQLite from source
wget https://www.sqlite.org/2024/sqlite-autoconf-3420000.tar.gz
tar -xvf sqlite-autoconf-3420000.tar.gz
cd sqlite-autoconf-3420000
./configure --prefix=/usr
make
make install
