<?php

use Spiral\Goridge;
use Spiral\RoadRunner;
use App\EchoService;

ini_set('display_errors', 'stderr');
require "vendor/autoload.php";

$server = new \Spiral\GRPC\Server();
$server->registerService(\Service\JobInterface::class, new \App\JobService());

$worker = new RoadRunner\Worker(new Goridge\StreamRelay(STDIN, STDOUT));
$server->serve($worker);
