#!/bin/bash

# Fetch the latest SQLite version from the website
LATEST_VERSION=$(curl -s https://www.sqlite.org/download.html | grep -oP 'sqlite-autoconf-\K[0-9]+' | head -1)
SQLITE_URL="https://www.sqlite.org/2024/sqlite-autoconf-${LATEST_VERSION}.tar.gz"

echo "Latest SQLite version detected: ${LATEST_VERSION}"
echo "Downloading SQLite source..."

# Download the SQLite source
curl -fSL "${SQLITE_URL}" -o "sqlite-autoconf-${LATEST_VERSION}.tar.gz"

# Check if the file was downloaded successfully
if [ ! -f "sqlite-autoconf-${LATEST_VERSION}.tar.gz" ]; then
    echo "Failed to download SQLite source. Exiting."
    exit 1
fi

# Extract the archive
echo "Extracting SQLite..."
tar -xzf "sqlite-autoconf-${LATEST_VERSION}.tar.gz"

# Navigate into the extracted directory
cd "sqlite-autoconf-${LATEST_VERSION}" || exit

# Configure, build, and install SQLite
echo "Building SQLite..."
./configure --prefix=/usr
make
make install

# Verify installation
sqlite3 --version
