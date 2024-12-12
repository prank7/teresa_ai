#!/bin/bash

# Define SQLite version and binary URL
SQLITE_VERSION="3420000"
SQLITE_URL="https://www.sqlite.org/2024/sqlite-tools-linux-x86-${SQLITE_VERSION}.zip"

# Download precompiled SQLite binary
echo "Downloading SQLite binary..."
curl -fSL "${SQLITE_URL}" -o sqlite-tools-linux-x86-${SQLITE_VERSION}.zip

# Check if the file was downloaded successfully
if [ ! -f "sqlite-tools-linux-x86-${SQLITE_VERSION}.zip" ]; then
    echo "Failed to download SQLite binary. Exiting."
    exit 1
fi

# Extract the binary
echo "Extracting SQLite binary..."
unzip -o sqlite-tools-linux-x86-${SQLITE_VERSION}.zip -d /usr/local/bin

# Verify installation
/usr/local/bin/sqlite3 --version
