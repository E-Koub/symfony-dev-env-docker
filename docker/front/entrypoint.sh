#!/bin/bash

# Set variables for better readability and maintenance
SRC_DIR="/app"
TMP_DIR="tmp"

# Check if package.json exists 
if [ ! -f "$SRC_DIR/package.json" ]; then

  # Clean up and prepare the temporary directory

  ng new "my-app" --defaults --directory ./; \
  # build the app
  RUN npm run build
  # Copy the build output to replace the default nginx contents.
  COPY --from=build /app/dist /usr/share/nginx/html
  
fi