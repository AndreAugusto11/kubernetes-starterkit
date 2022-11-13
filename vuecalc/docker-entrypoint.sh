#!/bin/sh
ROOT_DIR=./dist

# Replace env vars in files served by NGINX
for file in $ROOT_DIR/js/*.js* $ROOT_DIR/index.html $ROOT_DIR/precache-manifest*.js;
do
  sed -i 's|VUE_APP_EXPRESSED_BASE_URL_PLACEHOLDER|'${VUE_APP_EXPRESSED_BASE_URL}'|g' $file
  sed -i 's|VUE_APP_HAPPY_BASE_URL_PLACEHOLDER|'${VUE_APP_HAPPY_BASE_URL}'|g' $file
  # Your other variables here...
done

http-server dist -p 2000