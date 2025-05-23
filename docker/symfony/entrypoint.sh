#!/bin/bash

# Set variables for better readability and maintenance
SRC_DIR="/var/www/app"
TMP_DIR="tmp"

# Check if composer.json exists (meaning Symfony project is already installed)
if [ ! -f "$SRC_DIR/composer.json" ]; then

  echo "Creating Symfony project...ok"
  # Clean up and prepare the temporary directory
  rm -Rf $TMP_DIR
  symfony new "$TMP_DIR" --webapp --no-interaction
  cd $TMP_DIR
  cp -Rp . ..
  cd -
  rm -Rf $TMP_DIR/  
fi

set -e

# Install vendors if needed
if [ ! -d "$SRC_DIR/vendor" ]; then
  composer install
fi

# Lancer PHP-FPM
exec php-fpm
