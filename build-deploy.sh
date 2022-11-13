#!/bin/bash
echo "***********************************************************"
echo "Welcome to Calculator Service build and deploy scripting!"
echo "***********************************************************"

while getopts 'v:' OPTION; do
  case "$OPTION" in
    v)
      version="$OPTARG"
      echo "version $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
echo $version
read -rsp $'Press enter to continue...\n'

echo "*****************************************************"
echo "Starting Vuecalc service production build"
echo "*****************************************************"
cd vuecalc
sh build.sh -v $version
echo "*****************************************************"
echo "Starting Expressed service production build"
echo "*****************************************************"
cd ../expressed
sh build.sh -v $version
echo "*****************************************************"
echo "Starting Happy service production build"
echo "*****************************************************"
cd ../happy
sh build.sh -v $version
echo "*****************************************************"
echo "Deployment completed successfully!"
echo "*****************************************************"