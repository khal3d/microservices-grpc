<?php

require "vendor/autoload.php";

$client = new \Service\JobClient('grpc_jobs_service:9001', [
    'credentials' => Grpc\ChannelCredentials::createInsecure(),
]);

$request = new \Service\JobRequest();

for ($x = 0; $x <= 1000; $x++) {
    $request->setJob($x);

    list($reply, $status) = $client->getJobDetails($request)->wait();
    printf("\n[Time: %d] Reply: %s - Round: %d\n", microtime(true), $reply->getTitle(), $reply->getId());
}
