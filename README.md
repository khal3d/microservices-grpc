# microservices-grpc
Just a working example to work with gRPC &amp; PHP in a microservice architecture

# Get Started

```
docker-compose up -d --remove-orphans --force-recreate


docker exec -it grpc_jobs_service bash
composer install
composer spiral-gen-proto

docker exec -it grpc_jobs_client bash
composer install
composer gen-proto

# Test sending requests from the client to the service
php index.php
```
