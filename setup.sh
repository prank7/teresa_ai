#!/bin/bash
# Download and install SQLite 3.42.0 (adjust if newer versions exist)
wget https://www.sqlite.org/2024/sqlite-autoconf-3420000.tar.gz
tar -xvf sqlite-autoconf-3420000.tar.gz
cd sqlite-autoconf-3420000
./configure --prefix=/usr
make
make install
