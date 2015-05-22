#!/bin/bash
set +e
# Create scm info
./scm-source.sh

# deploy
mai
sudo docker build --no-cache -t pierone.stups.zalan.do/greendale/docs:1.0-SNAPSHOT .
sudo docker push pierone.stups.zalan.do/greendale/docs:1.0-SNAPSHOT
deploy_set="green"
if senza instances documentation | grep green; then
    deploy_set="blue"
fi
senza create docs-deploy.yaml $deploy_set 1.0-SNAPSHOT

# restore scm info
git checkout scm-source.json

echo "Application deployed! You will be able to access it under https://docs-$1.greendale.zalan.do in the following minutes."
echo "To redirect all the traffic you can use:"
echo "   $ senza traffic documentation $deploy_set 100"
echo "To check if the application was already created, you can use:"
echo "   $ senza events documentation $deploy_set -w 10"
echo "Don't forget to remove the old stack!!!!!!"
echo "   $ senza delete documentation OLD_STACK"
set -e
