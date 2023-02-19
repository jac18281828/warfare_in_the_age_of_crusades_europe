#!/usr/bin/bash

set -e

docker compose build
for map in gibraltar iberia iberia2 iberia_africa languedoc pyrenees
do
    echo "building ${map}"
    docker compose run ${map}
done    
