#!/bin/bash

# Define SQLite version and download URL
SQLITE_VERSION="3470200"
SQLITE_URL="https://www.sqlite.org/2024/sqlite-autoconf-${SQLITE_VERSION}.tar.gz"

echo "Downloading SQLite version ${SQLITE_VERSION}..."

# Download the SQLite source
curl -fSL "${SQLITE_URL}" -o "sqlite-autoconf-${SQLITE_VERSION}.tar.gz"

# Check if the file was downloaded successfully
if [ ! -f "sqlite-autoconf-${SQLITE_VERSION}.tar.gz" ]; then
    echo "Failed to download SQLite source. Exiting."
    exit 1
fi

# Extract the archive
echo "Extracting SQLite..."
tar -xzf "sqlite-autoconf-${SQLITE_VERSION}.tar.gz"

# Navigate into the extracted directory
cd "sqlite-autoconf-${SQLITE_VERSION}" || exit

# Configure, build, and install SQLite
echo "Building SQLite..."
./configure --prefix=/usr
make
make install

# Verify installation
sqlite3 --version
