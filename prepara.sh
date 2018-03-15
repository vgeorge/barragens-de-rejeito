#!/bin/bash

mkdir -p barragens-de-rejeito

cd barragens-de-rejeito

curl 'http://overpass-api.de/api/interpreter' --data 'data=%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0Aarea(3600059470)-%3E.searchArea%3B%0A(%0A++way%5Breservoir_type%3D%22tailings%22%5D(area.searchArea)%3B%0A++relation%5Breservoir_type%3D%22tailings%22%5D(area.searchArea)%3B%0A)%3B%0A%2F%2F+print+results%0Aout+body%3B%0A%3E%3B%0Aout+skel+qt%3B' --compressed > barragens-de-rejeito.json
osmtogeojson barragens-de-rejeito.json > barragens-de-rejeito.geojson
ogr2ogr -f csv barragens-de-rejeito.csv barragens-de-rejeito.geojson
ogr2ogr -f ods barragens-de-rejeito.ods barragens-de-rejeito.geojson
ogr2ogr -f xlsx barragens-de-rejeito.xlsx barragens-de-rejeito.geojson
ogr2ogr -f kml barragens-de-rejeito.kml barragens-de-rejeito.geojson
geo2topo barragens-de-rejeito.geojson > barragens-de-rejeito.topojson

cd ..

zip -r barragens-de-rejeito.zip . -i "barragens-de-rejeito/*"

cp barragens-de-rejeito/barragens-de-rejeito.csv .

rm -rf ./barragens-de-rejeito