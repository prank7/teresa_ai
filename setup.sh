#!/bin/bash

# Download SQLite source using curl
curl -O https://www.sqlite.org/2024/sqlite-autoconf-3420000.tar.gz

# Extract and build SQLite
tar -xvf sqlite-autoconf-3420000.tar.gz
cd sqlite-autoconf-3420000
./configure --prefix=/usr
make
make install
