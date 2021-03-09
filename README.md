# microservices-grpc
Just a working example to work with gRPC &amp; PHP in a microservice architecture

# Get Started

```
docker-compose up -d --remove-orphans --force-recreate


docker-compose exec jobs_server bash
composer install
composer spiral-gen-proto

docker-compose exec jobs_client bash
composer install
composer gen-proto

# Test sending requests from the client to the service
php index.php
```

# Stress Test

```
docker-compose exec jobs_client bash
ghz --insecure --proto /var/www/protos/service.proto --call service.Job.getJobDetails -d '{"job": 1}' grpc_jobs_server:9001 --concurrency=200 --total=2000
```
