FROM grpc/php

RUN apt-get update -y &&\
    apt-get install -y git zip automake libtool\
    && apt-get -y autoremove\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*\
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# Install GoLang
RUN curl -s https://dl.google.com/go/go1.15.4.linux-amd64.tar.gz | tar -v -C /usr/local -xz
ENV PATH $PATH:/usr/local/go/bin

# Install Google gRPC tools (protoc & the php plugin)
RUN git clone --depth 1 -b v1.30.0 https://github.com/grpc/grpc /root/grpc\
    && cd /root/grpc\
    && git submodule update --init\
    && make grpc_php_plugin\
    && mv /root/grpc/bins/opt/grpc_php_plugin /usr/local/bin/\
    && mv /root/grpc/bins/opt/protobuf/protoc /usr/local/bin/\
    && rm -rf /root/grpc/

# Install Spiral gRPC tools & Roadrunner Server
RUN git clone --depth 1 -b v1.4.0 https://github.com/spiral/php-grpc.git /root/php-grpc\
    && /root/php-grpc/build.sh\
    && mv /root/php-grpc/protoc-gen-php-grpc /usr/local/bin/protoc-gen-php-grpc\
    && mv /root/php-grpc/rr-grpc /usr/local/bin/rr-grpc\
    && rm -rf /root/php-grpc/

# Install gzh (a gRPC benchmarking and load testing tool)
RUN git clone https://github.com/bojand/ghz /root/ghz\
    && cd /root/ghz\
    && make build\
    && mv /root/ghz/dist/ghz /usr/local/bin/\
    && mv /root/ghz/dist/ghz-web /usr/local/bin/


RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer;

WORKDIR /root/grpc

# Removed the Go module cacheing
RUN go clean -modcache

WORKDIR /var/www/
EXPOSE 9001

CMD tail -f /dev/null
