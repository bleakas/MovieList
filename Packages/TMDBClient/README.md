# TMDBClient

Package for themoviedb.org API
Code **MUST** be only automatically generated from openapi.yml file
You should not modify the code of this package manually because it may be overriden
The only way to modify API code is to update openapi.yml file and perform generation operation

# Generation
Package uses [CreateAPI](https://github.com/CreateAPI/CreateAPI/) tool to automatically generate networking layer
Just install CreateAPI with `brew install create-api`
To generate API go to openapi.yml directory and perform
```
create-api generate openapi.yml --config-option module=TMDBClient --output TMDBClient
```
