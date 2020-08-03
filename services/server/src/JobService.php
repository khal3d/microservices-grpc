<?php

namespace App;

use Service\JobInterface;
use Service\JobRequest;
use Service\JobResponse;
use Spiral\GRPC\ContextInterface;
use Service\Message;

class JobService implements JobInterface
{
    public function getJobDetails(ContextInterface $ctx, JobRequest $in): JobResponse
    {
        $out = new JobResponse();

        $out->setId($in->getJob());
        $out->setTitle('Great job at Basharsoft, Maadi');

        return $out;
    }
}
