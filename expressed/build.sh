#!/bin/bash

while getopts 'v:' OPTION; do
  case "$OPTION" in
    v)
      version="$OPTARG"
      echo "version $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-v version_name]" >&2
      exit 1
      ;;
  esac
done

docker build --platform=linux/amd64 -t aaugusto11/expressed:$version .
docker push aaugusto11/expressed:$version