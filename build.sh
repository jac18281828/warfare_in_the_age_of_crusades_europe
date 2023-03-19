#!/usr/bin/bash

set -e

docker compose build
for map in cathar_france gibraltar iberia iberia2 iberia_africa languedoc2 pyrenees
do
    echo "building ${map}"
    docker compose run ${map}
done    
