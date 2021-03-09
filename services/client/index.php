<?php

require "vendor/autoload.php";

$client = new \Service\JobClient('grpc_jobs_server:9001', [
    'credentials' => Grpc\ChannelCredentials::createInsecure(),
]);

$request = new \Service\JobRequest();

for ($x = 0; $x <= 100000; $x++) {
    $request->setJob($x);

    $timeoutMs = 100*1000; // 100ms
    list($reply, $status) = $client->getJobDetails($request, [], ['timeout' => $timeoutMs])->wait();

    if ($status->code == \Grpc\STATUS_OK) {
        printf("\n[Time: %d] Reply: %s - Round: %d\n", microtime(true), $reply->getTitle(), $reply->getId());
    } else {
        echo $status->details.PHP_EOL;
    }
}
